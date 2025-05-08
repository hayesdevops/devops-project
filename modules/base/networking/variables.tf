variable "environment" {
  type        = string
  description = "Environment name"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC/VNET"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet CIDR blocks"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet CIDR blocks"
}

variable "resource_tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}

variable "network_tier" {
  type        = string
  description = "Network tier (public/private/data)"
  validation {
    condition     = contains(["public", "private", "data"], var.network_tier)
    error_message = "Network tier must be public, private, or data."
  }
}

locals {
  network_tags = merge(
    var.resource_tags,
    {
      NetworkTier = var.network_tier
    }
  )
}
