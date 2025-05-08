variable "cost_center" {
  type        = string
  description = "Cost center code for billing"
  default     = "devops-infrastructure"  # Change this default as needed
}

variable "owner" {
  type        = string
  description = "Team/Individual responsible for the resource"
  default     = "platform-team"  # Change this default as needed
}