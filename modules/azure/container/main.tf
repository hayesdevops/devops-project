# Azure Container Module
module "tags" {
  source         = "../../base/tags"
  environment    = var.environment
  cost_center    = var.cost_center
  owner          = var.owner
  cloud_provider = "azure"
}

locals {
  common_tags = merge(
    module.tags.tags,
    {
      Module = "azure_container"
    }
  )
}