variable "environment" {
  description = "Environment name for backend resources"
  type        = string
  default     = "shared"
}

variable "aws_region" {
  description = "AWS region for backend resources"
  type        = string
  default     = "us-west-2"
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket for state storage"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
  default     = "terraform-lock"
}

variable "azure_location" {
  description = "Azure location for backend resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "terraform-state-rg"
}

variable "storage_account_name" {
  description = "Name of the Azure storage account"
  type        = string
}

variable "container_name" {
  description = "Name of the Azure storage container"
  type        = string
  default     = "tfstate"
}
