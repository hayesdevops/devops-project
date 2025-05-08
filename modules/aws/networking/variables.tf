variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod" # or "shared" for shared services
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "AWS Availability Zone"
  type        = string
}

variable "create_transit_gateway" {
  description = "Flag to create a Transit Gateway within the module."
  type        = bool
  default     = true
}

variable "transit_gateway_id" {
  description = "Transit Gateway ID to attach the VPC to if not created in this module. Ignored if create_transit_gateway is true."
  type        = string
  default     = ""
}

variable "amazon_side_asn" {
  description = "Amazon side ASN for the Transit Gateway."
  type        = number
  default     = 64512
}

variable "create_vpn_endpoint" {
  description = "Boolean flag to create a VPN endpoint (Elastic IP)"
  type        = bool
  default     = true
}

variable "cost_center" {
  type        = string
  description = "Cost center for billing purposes"
}

variable "owner" {
  type        = string
  description = "Team/Individual responsible for the resource"
}