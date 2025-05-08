output "monitoring_config" {
  description = "Common monitoring configuration"
  value = {
    aws = {
      namespace = var.metrics_namespace
      dimensions = {
        Environment = var.environment
      }
      retention_days = var.log_retention_days
    }
    azure = {
      metric_namespace = var.metrics_namespace
      dimensions = {
        environment = var.environment
      }
      retention_days = var.log_retention_days
    }
  }
}

output "alerts" {
  description = "Standardized alert configurations"
  value = var.alerts
}
