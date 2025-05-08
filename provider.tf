terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Add version constraint
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "aws" {
  alias  = "backend"
  region = "us-west-2"
}

provider "aws" {
  alias  = "shared"
  region = "us-west-2"
}

provider "aws" {
  alias  = "prod"
  region = "us-west-2"
}

provider "azurerm" {
  features {}
}

