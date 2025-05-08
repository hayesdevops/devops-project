# Azure Container Module
# Deploys a containerized application on Azure Container Instances (ACI) with VNET integration.


locals {
  common_tags = {
    environment = var.environment
    terraform   = "true"
    module      = "azure_container"
  }
}