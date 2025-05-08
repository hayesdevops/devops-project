locals {
  common_tags = merge(
    {
      Environment   = var.environment
      CostCenter   = var.cost_center
      Owner        = var.owner
      ManagedBy    = "terraform"
      LastModified = timestamp()
    },
    var.additional_tags
  )
}

output "tags" {
  description = "Standardized tag map for resources"
  value       = local.common_tags
}
