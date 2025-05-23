variable "name" {
  type        = string
  description = "Name of the container deployment"
}

variable "resource_tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}

variable "container_image" {
  type        = string
  description = "Container image to deploy"
}

variable "cpu" {
  type        = number
  description = "CPU units to allocate"
}

variable "memory" {
  type        = number
  description = "Memory to allocate in MB"
}

variable "application_name" {
  type        = string
  description = "Name of the application"
}

variable "service_tier" {
  type        = string
  description = "Service tier (frontend/backend/data)"
  validation {
    condition     = contains(["frontend", "backend", "data"], var.service_tier)
    error_message = "Service tier must be frontend, backend, or data."
  }
}

variable "environment" {
  type        = string
  description = "Deployment environment"
  validation {
    condition     = contains(["dev", "staging", "prod", "shared"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, shared."
  }
}

variable "container_registry" {
  type        = string
  description = "Container registry URL"
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-_./]*$", var.container_registry))
    error_message = "Container registry must be a valid URL."
  }
}

locals {
  container_tags = merge(
    var.resource_tags,
    {
      ApplicationName = var.application_name
      ServiceTier    = var.service_tier
    }
  )
}
