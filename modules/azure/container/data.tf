data "azurerm_subnet" "this" {
  name                 = split("/", var.container_subnet_id)[10]
  virtual_network_name = split("/", var.container_subnet_id)[8]
  resource_group_name  = split("/", var.container_subnet_id)[4]
}
