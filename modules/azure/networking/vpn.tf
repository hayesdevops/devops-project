resource "azurerm_public_ip" "this" {
  name                = "${var.environment}-vpn-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.networking.name  # Fix: use name instead of id
  allocation_method   = var.public_ip_allocation_method
  tags                = local.common_tags
}

resource "azurerm_virtual_network_gateway" "this" {
  name                = "${var.environment}-vpn-gateway"
  location            = var.location
  resource_group_name = azurerm_resource_group.networking.name  # Fix: use name instead of id
  type                = "Vpn"
  vpn_type            = var.vpn_type
  sku                 = var.vpn_gateway_sku
  tags                = local.common_tags

  ip_configuration {
    name                 = "vnetGatewayConfig"
    public_ip_address_id = azurerm_public_ip.this.id
    subnet_id            = azurerm_subnet.transit.id
  }

  vpn_client_configuration {
    address_space = [var.vpn_client_address_pool]
  }
}

resource "azurerm_local_network_gateway" "this" {
  name                = "${var.environment}-aws-local-network-gateway"
  location            = var.location
  resource_group_name = azurerm_resource_group.networking.id
  gateway_address     = var.aws_transit_gateway_vpn_ip
  address_space       = [var.aws_address_space]
}

resource "azurerm_virtual_network_gateway_connection" "this" {
  name                       = "${var.environment}-vpn-connection"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.networking.id
  virtual_network_gateway_id = azurerm_virtual_network_gateway.this.id
  local_network_gateway_id   = azurerm_local_network_gateway.this.id
  type                       = "IPsec"
  shared_key                 = var.vpn_shared_key
  tags                       = local.common_tags
}