terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
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
  alias  = "shared"
  region = "us-west-2"
}
provider "aws" {
  alias  = "prod"
  region = "us-west-2" # or your desired region

}

provider "azurerm" {
  features {}
}

