# IAM role for CONTROL PLANE
resource "aws_iam_role" "cluster" {
  name = "${var.name}-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role.json
}

# allow EKS to assume the IAM role
data "aws_iam_policy_document" "cluster_assume_role" {
    statement {
      effect = "Allow"
      actions = ["sts:AssumeRole"]
      principals {
        type = "Service"
        identifiers = ["eks.amazonaws.com"]
      }
    }
}

# atach the permissions to CONTROL PLANE needs to manage resources (EC2, SG, ENI, etc.)
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.cluster.name
}

# VPC
data "aws_vpc" "default" {
    default = true
}

# SUBNETS
data "aws_subnets" "default" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}

# create CONTROL PLANE for EKS
resource "aws_eks_cluster" "cluster" {
  name = var.name
  role_arn = aws_iam_role.cluster.arn
  version = "1.36"

  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }

  # create IAM role/permissions first so that EKS managed EC2 infrastructure can be deleted
  depends_on = [ aws_iam_role_policy_attachment.AmazonEKSClusterPolicy ]
}

# IAM role for WORKER NODE GROUP
resource "aws_iam_role" "node_group" {
  name = "${var.name}-node-group"
  assume_role_policy = data.aws_iam_policy_document.node_assume_role.json
}

# allow EC2 instances to assume IAM role
data "aws_iam_policy_document" "node_assume_role" {
    statement {
      effect = "Allow"
      actions = ["sts:AssumeRole"]
      principals {
        type = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }
    }
}

# attach the permissions the WORKER NODE GROUP needs to connect to EKS CLUSTERS
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.node_group.name
}

# attach the permissions the WORKER NODE GROUP needs to modify IP/network configuration
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.node_group.name
}

resource "aws_eks_node_group" "nodes" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = var.name
  node_role_arn = aws_iam_role.node_group.arn
  subnet_ids = data.aws_subnets.default.ids
  instance_types = var.instance_types

  scaling_config {
    min_size = var.min_size
    max_size = var.max_size
    desired_size = var.desired_size
  }
  
  # ensure IAM role permissions are created before and deleted after the WORKER NODE GROUP so that EC2 and ENI properly delete
  depends_on = [ aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy, aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly, aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy ]
}