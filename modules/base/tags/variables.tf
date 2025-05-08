variable "environment" {
  type        = string
  description = "Environment name (dev/staging/prod)"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "cost_center" {
  type        = string
  description = "Cost center code for billing"
}

variable "owner" {
  type        = string
  description = "Team/Individual responsible for the resource"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional resource tags"
  default     = {}
}

variable "cloud_provider" {
  type        = string
  description = "Cloud provider (aws/azure)"
  validation {
    condition     = contains(["aws", "azure"], var.cloud_provider)
    error_message = "Provider must be aws or azure."
  }
}

# Add provider-specific tag validation
locals {
  aws_tag_regex   = "^[a-zA-Z0-9+\\-=._:/@]+$"
  azure_tag_regex = "^[a-zA-Z0-9+\\-=._:/@]+$"
  
  tag_validation = {
    aws   = local.aws_tag_regex
    azure = local.azure_tag_regex
  }
}
