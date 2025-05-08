resource "azurerm_virtual_network" "this" {
  name                = "${var.environment}-vnet"
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.networking.name 
  tags                = local.common_tags
}

resource "azurerm_subnet" "container" {
  name                 = "${var.environment}-container-subnet"
  resource_group_name  = azurerm_resource_group.networking.id
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.container_subnet_prefix]
}

resource "azurerm_subnet" "transit" {
  name                 = "${var.environment}-transit-subnet"
  resource_group_name  = azurerm_resource_group.networking.id
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.transit_subnet_prefix]
}