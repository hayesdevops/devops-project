variable "enable_monitoring" {
  type        = bool
  description = "Enable detailed monitoring"
  default     = true
}

variable "metrics_namespace" {
  type        = string
  description = "Namespace for CloudWatch/Azure Monitor metrics"
}

variable "log_retention_days" {
  type        = number
  description = "Number of days to retain logs"
  default     = 30
}

variable "alerts" {
  type = map(object({
    threshold     = number
    period       = number
    statistic    = string
    description  = string
  }))
  description = "Map of alerts to create"
  default     = {}
}
