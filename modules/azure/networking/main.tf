
locals {
  common_tags = {
    environment = var.environment
    terraform   = "true"
    module      = "azure-networking"
    purpose     = "cross-cloud-connectivity"
  }
}