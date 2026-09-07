output "service_endpoint" {
  value = module.simple_app.service_endpoint
  description = "The k8s service endpoint"
}