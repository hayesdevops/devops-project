# Infrastructure Changes Overview

## Summary of Approach

Applied Terraform best practices by implementing a modular design with shared base modules,
removing duplication between cloud providers, and maintaining provider-specific implementations
where necessary. This approach improves maintainability and ensures consistent resource configuration
across cloud providers.

## Module Structure
```
modules/
├── base/
│   ├── container/
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── monitoring/
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── networking/
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── tags/
│       ├── variables.tf
│       └── outputs.tf
├── aws/
│   ├── container/
│   └── networking/
└── azure/
    ├── container/
    └── networking/
```

## Base Modules Overview

### Tags Module
- Centralized tag management
- Provider-specific validation
- Standard tag enforcement
- Automatic timestamp management

### Monitoring Module
- Cross-cloud metrics configuration
- Standardized alert definitions
- Log retention policies
- Common monitoring interfaces

### Networking Module
- Shared networking variables
- Cross-cloud connectivity definitions
- Common subnet structures
- Network tier validation

### Container Module
- Standard container definitions
- Resource allocation templates
- Common deployment patterns
- Service configuration baseline

## AWS Modules Design Decisions and changes

### Networking Module
- Route table configuration
  - Dynamic Internet Gateway setup
  - Configurable public/private routing
  - Transit Gateway integration
- Variable-based CIDR blocks
- Standardized resource tagging

### Container Module (ECS)
- Configurable resource allocation:
  - CPU/Memory settings
  - Network mode options
  - Launch type selection
- Enhanced container support:
  - Multi-container tasks
  - Dynamic port mapping
  - Resource allocation controls
- Service improvements:
  - Configurable desired count
  - Multi-subnet support
  - Public IP assignment toggle

## Azure Modules

### Container Module
- Resource Management:
  - CPU/Memory controls
  - Environment variable support
  - Network profile integration
- Security Enhancements:
  - Private IP by default
  - Health monitoring
  - Diagnostic settings
- Monitoring Integration:
  - Log Analytics
  - Health probes
  - Diagnostic outputs

### Networking Module
- Resource Organization:
  - Dedicated resource groups
  - Consistent naming scheme
  - Lifecycle management
- Security Controls:
  - prevent_destroy where needed
  - Proper RBAC integration
  - Resource validation

## Resource Tagging Standards

### Required Tags
All resources must include these tags:
- `Environment` - (dev/staging/prod)
- `CostCenter` - Department/Project code
- `Owner` - Team responsible
- `ManagedBy` - "terraform"
- `LastModified` - Timestamp of last change

### Module-specific Tags
- Networking resources: Include `NetworkTier`
- Container resources: Include `ApplicationName` and `ServiceTier`

### Tag Validation
- AWS tags must match pattern: ^[a-zA-Z0-9+\-=._:/@]+$
- Azure tags must match pattern: ^[a-zA-Z0-9+\-=._:/@]+$
- Tag validation is enforced through the base tags module
- Cloud provider-specific validation through regex patterns

### Base Modules Design

#### Tags Module
- Centralized tag management
- Cloud provider-specific validation
- Required tags enforcement:
  - Environment
  - CostCenter
  - Owner
  - ManagedBy
  - LastModified
- Supports additional custom tags
- Provider-specific tag format validation

## Deployment Methods 

### Manual Deployment
```bash
terraform init      # Initialize providers and modules
terraform plan     # Review changes
terraform apply    # Apply infrastructure changes
```

### GitHub Actions Setup
Required secrets:
- AWS_ROLE_ARN
- AZURE_CREDENTIALS
- TF_STATE_STORAGE

Environment configuration:
- shared-services
- production

## GitHub Actions Workflows

### Pull Request (PR) Workflow
Automatically runs when PRs are opened/updated against main branch:
- Terraform format checking
- TFLint static analysis
- Configuration validation
- Security scanning with Checkov
- Infrastructure plan generation
- Posts results as PR comment

### Release Workflow
Triggers on new release publication:
1. Validation Stage:
   - Configuration validation
   - Security scanning
2. Shared Services Stage:
   - Deploys network infrastructure
   - Requires environment approval
3. Production Stage:
   - Deploys AWS/Azure resources
   - Creates deployment summary
   - Generates documentation

Required Secrets:
- AWS_ROLE_ARN: AWS IAM role for deployments
- AZURE_CREDENTIALS: Azure service principal
- AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY: AWS credentials
- AZURE_CLIENT_ID/SECRET/SUBSCRIPTION_ID/TENANT_ID: Azure auth

## Testing Infrastructure

### Terratest Implementation
Tests are located in the `/test` directory and validate:
- VPC/VNET creation and configuration
- Subnet allocation and routing
- Container service deployment
- Cross-cloud connectivity
- Resource tagging compliance

### Terratest Configuration
- Located in `/test` directory
- Requires Go 1.20+
- Uses Terratest modules for AWS and Azure
- Supports parallel test execution
- Automated cleanup after tests

### Test Prerequisites
- Valid AWS credentials with required permissions
- Valid Azure service principal
- Go environment configured
- Required environment variables set
- Terraform binary in PATH

For detailed setup instructions and examples, see [Test README](./test/README.md)

### Running Tests Locally
```bash
cd test
go test -v ./...
```

### CI/CD Integration
- Tests run automatically on pull requests
- Validates infrastructure changes
- Ensures tag compliance
- Verifies cross-cloud connectivity
- Results posted as PR comments
