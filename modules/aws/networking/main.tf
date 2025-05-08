# AWS Networking Module
# Creates AWS networking infrastructure including:
# - VPC with specified CIDR block
# - Public and private subnets in specified availability zone
# - Transit Gateway (optional) with specified ASN
# - Transit Gateway VPC attachment (when using existing or new TGW)
# - VPN endpoint with Elastic IP (when create_vpn_endpoint is true)
# 
# The module can either create a new Transit Gateway or use an existing one
# through the transit_gateway_id variable. All resources are tagged with
# environment and terraform management tags.

locals {
  tgw_id = var.create_transit_gateway ? aws_ec2_transit_gateway.this[0].id : var.transit_gateway_id
  common_tags = {
    Environment = var.environment
    Terraform   = "true"
    Module      = "aws_networking"
  }
}