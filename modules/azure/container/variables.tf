variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod" # or "shared" for shared services
}

variable "container_subnet_id" {
  description = "ID of the subnet where the container group will be deployed (VNET integration)"
  type        = string
}

variable "container_image" {
  description = "Container image to deploy"
  type        = string
  default     = "carrumhealth/helloworld:stable"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "eastus" # or your preferred Azure region
}

variable "container_resource_group" {
  description = "Azure Container Resource Group Name (for container deployments)"
  type        = string
  default     = "my-azure-container-rg"
}

variable "container_cpu" {
  description = "CPU cores allocated to container"
  type        = number
  default     = 0.5
}

variable "container_memory" {
  description = "Memory allocated to container (in GB)"
  type        = number
  default     = 1.0
}

variable "container_port" {
  description = "Container port to expose"
  type        = number
  default     = 80
}

variable "environment_variables" {
  description = "Environment variables for the container"
  type        = map(string)
  default     = {}
}

variable "dns_name_label" {
  description = "DNS name label for the container group"
  type        = string
  default     = null
}

variable "network_profile_id" {
  description = "The ID of the Network Profile for the Container Group"
  type        = string
  default     = null
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace for container diagnostics"
  type        = string
  default     = null
}

variable "cost_center" {
  description = "Cost center for billing purposes"
  type        = string
}

variable "owner" {
  description = "Team/Individual responsible for the resource"
  type        = string
}