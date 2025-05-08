resource "azurerm_container_group" "this" {
  name                = "${var.environment}-aci"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  os_type            = "Linux"
  dns_name_label     = var.dns_name_label
  ip_address_type    = "Private"
  network_profile_id = var.network_profile_id != null ? var.network_profile_id : null


  subnet_ids = [var.container_subnet_id]

  container {
    name   = "app"
    image  = var.container_image
    cpu    = var.container_cpu
    memory = var.container_memory

    ports {
      port     = var.container_port
      protocol = "TCP"
    }

    environment_variables = var.environment_variables

    liveness_probe {
      http_get {
        path   = "/health"
        port   = var.container_port
        scheme = "Http"
      }
      initial_delay_seconds = 30
      period_seconds        = 10
    }
  }

  tags = local.common_tags
}