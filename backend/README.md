# Terraform State Backend Setup

This directory contains the infrastructure code for setting up remote state storage in both AWS and Azure.

## Setup Instructions

1. Initialize and apply the backend infrastructure:
```bash
terraform init
terraform apply -var="state_bucket_name=your-unique-bucket-name" -var="storage_account_name=yourstorageaccount"
```

2. After creation, you can configure your main Terraform projects to use these backends:

For AWS:
```hcl
terraform {
  backend "s3" {
    bucket         = "your-unique-bucket-name"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    use_lockfile   = true
  }
}
```

For Azure:
```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "yourstorageaccount"
    container_name       = "tfstate"
    key                 = "terraform.tfstate"
  }
}
```

## Authentication

For AWS:
```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
```

For Azure:
```bash
az login
```

## Notes
- Choose unique names for your S3 bucket and Azure storage account
- Ensure you have appropriate permissions in both clouds
- Backend resources should be created before any other infrastructure
