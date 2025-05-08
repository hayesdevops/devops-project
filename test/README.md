# Infrastructure Testing Guide

## Prerequisites
- Go 1.20 or later
- Terraform 1.5.0 or later
- AWS credentials configured
- Azure credentials configured

## Setup Instructions

1. Initialize Go module:
```bash
go mod init github.com/your-org/devops
go mod tidy
```

2. Install required Go packages:
```bash
go get github.com/gruntwork-io/terratest/modules/terraform
go get github.com/gruntwork-io/terratest/modules/aws
go get github.com/gruntwork-io/terratest/modules/azure
```

3. Configure environment variables:
```bash
# AWS Configuration
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-west-2"

# Azure Configuration
export ARM_CLIENT_ID="your-client-id"
export ARM_CLIENT_SECRET="your-client-secret"
export ARM_SUBSCRIPTION_ID="your-subscription-id"
export ARM_TENANT_ID="your-tenant-id"
```

## Running Tests

Run all tests:
```bash
go test -v ./...
```

Run specific test:
```bash
go test -v -run TestAWSNetworking
```

## Test Organization

- `networking_test.go`: Tests for VPC/VNET creation and routing
- `container_test.go`: Tests for container deployments
- `tags_test.go`: Tests for resource tagging compliance
