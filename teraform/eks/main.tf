provider "aws" {
  region = "eu-west-2"
}

module "eks_cluster" {
  source = "../modules/services/eks-cluster"

  name = "example-eks-cluster"
  min_size = 1
  max_size = 2
  desired_size = 1
  instance_types = ["t3.small"]
}

provider "kubernetes" {
  host = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(
    module.eks_cluster.cluster_certificate_authority[0].data
  )
  token = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.eks_cluster.cluster_name
}

module "simple_app" {
  source = "../modules/services/k8s-app"
  
  name = "simple-app"
  image = "ghcr.io/yashjagani17/secure-devsecops-release-platform:latest"
  replicas = 2
  container_port = 5000

  environment_variables = {
    PROVIDER = "Terraform"
  }

  # deploy app after CLUSTER
  depends_on = [ module.eks_cluster ]
}