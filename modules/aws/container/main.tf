# AWS Container Module
module "tags" {
  source         = "../../base/tags"
  environment    = var.environment
  cost_center    = var.cost_center
  owner          = var.owner
  cloud_provider = "aws"
}

locals {
  common_tags = merge(
    module.tags.tags,
    {
      Module = "aws_container"
    }
  )
}