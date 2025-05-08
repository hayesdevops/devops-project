resource "azurerm_resource_group" "this" {
  name     = var.container_resource_group
  location = var.location
  tags = {
    environment = var.environment
  }
}
