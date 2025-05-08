resource "azurerm_resource_group" "networking" {
  name     = var.network_resource_group
  location = var.location
  tags = {
    environment = var.environment
  }
}