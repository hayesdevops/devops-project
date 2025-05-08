# AWS Container Module
# This module deploys a containerized application on AWS using Amazon ECS with Fargate launch type by default

locals {
  common_tags = {
    Environment = var.environment
    Terraform   = "true"
    Module      = "aws_container"
  }
}