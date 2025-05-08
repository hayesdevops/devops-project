provider "aws" {
  region = var.aws_region
}

provider "azurerm" {
  features {}
}

# AWS Backend Resources
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket_name

  tags = {
    Environment = var.environment
    Purpose     = "Terraform State Storage"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = var.environment
    Purpose     = "Terraform State Locking"
  }
}

# Azure Backend Resources
resource "azurerm_resource_group" "terraform_state" {
  name     = var.resource_group_name
  location = var.azure_location

  tags = {
    environment = var.environment
    purpose     = "Terraform State Storage"
  }
}

resource "azurerm_storage_account" "terraform_state" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.terraform_state.name
  location                 = azurerm_resource_group.terraform_state.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  blob_properties {
    versioning_enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  min_tls_version = "TLS1_2"
  
  network_rules {
    default_action = "Deny"
    ip_rules       = [chomp(data.http.my_ip.body)]
  }

  tags = {
    environment = var.environment
    purpose     = "Terraform State Storage"
  }
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.terraform_state.name
  container_access_type = "private"
}

data "http" "my_ip" {
  url = "https://api.ipify.org"
}
