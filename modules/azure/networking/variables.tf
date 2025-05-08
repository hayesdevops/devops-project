variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod" # or "shared" for shared services
  validation {
    condition     = contains(["dev", "staging", "prod", "shared"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, shared."
  }
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "eastus" # or your preferred Azure region
}

variable "network_resource_group" {
  description = "Azure Networking Resource Group Name (for VNET, subnets, VPN Gateway/Connection)"
  type        = string
  default     = "my-azure-network-rg"
}

variable "vnet_address_space" {
  description = "Address space for the VNET"
  type        = string
  validation {
    condition     = can(cidrhost(var.vnet_address_space, 0))
    error_message = "VNET address space must be a valid CIDR block."
  }
}

variable "container_subnet_prefix" {
  description = "Address prefix for container subnet"
  type        = string
}

variable "transit_subnet_prefix" {
  description = "Address prefix for transit subnet"
  type        = string
}

variable "vpn_client_address_pool" {
  description = "VPN client address pool (CIDR block)"
  type        = string
}

variable "aws_transit_gateway_vpn_ip" {
  description = "AWS Transit Gateway VPN endpoint IP from the shared services VPC"
  type        = string
}

variable "vpn_shared_key" {
  description = "Shared key for the VPN connection"
  type        = string
}

variable "aws_address_space" {
  description = "Address space for the AWS network (for the local network gateway)"
  type        = string
}

variable "vpn_gateway_sku" {
  description = "The SKU of the VPN Gateway"
  type        = string
  default     = "VpnGw1"
}

variable "public_ip_allocation_method" {
  description = "Defines the allocation method for the public IP address"
  type        = string
  default     = "Dynamic"
}

variable "vpn_type" {
  description = "The type of VPN gateway"
  type        = string
  default     = "RouteBased"
}

variable "cost_center" {
  type        = string
  description = "Cost center code for billing"
}

variable "owner" {
  type        = string
  description = "Team/Individual responsible for the resource"
}