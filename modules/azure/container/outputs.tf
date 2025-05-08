output "container_service_endpoint" {
  description = "Private IP of the deployed ACI Container Group"
  value       = azurerm_container_group.this.ip_address
}


output "container_group_id" {
  description = "ID of the Container Group"
  value       = azurerm_container_group.this.id
}

output "fqdn" {
  description = "FQDN of the Container Group"
  value       = var.dns_name_label != null ? azurerm_container_group.this.fqdn : null
}

output "container_name" {
  description = "Name of the deployed container"
  value       = "${var.environment}-aci"
}