output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "The VPC CIDR block"
  value       = var.vpc_cidr
}

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "Private Subnet ID"
  value       = aws_subnet.private.id
}

output "transit_gateway_attachment_id" {
  description = "Transit Gateway Attachment ID (if created)"
  value       = length(aws_ec2_transit_gateway_vpc_attachment.this) > 0 ? aws_ec2_transit_gateway_vpc_attachment.this[0].id : ""
}

output "vpn_endpoint_ip" {
  description = "The public IP for the VPN endpoint in the shared services VPC"
  value       = var.create_vpn_endpoint ? aws_eip.vpn_endpoint[0].public_ip : ""
}

output "transit_gateway_id" {
  description = "Transit Gateway ID, either created in this module or provided externally."
  value       = local.tgw_id
}