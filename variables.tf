variable "cost_center" {
  type        = string
  description = "Cost center code for billing"
  default     = "devops-infrastructure"
  validation {
    condition     = length(var.cost_center) > 0
    error_message = "Cost center must not be empty."
  }
}

variable "owner" {
  type        = string
  description = "Team/Individual responsible for the resource"
  default     = "platform-team"
  validation {
    condition     = length(var.owner) > 0
    error_message = "Owner must not be empty."
  }
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  default     = "prod"
  validation {
    condition     = contains(["dev", "staging", "prod", "shared"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, shared."
  }
}