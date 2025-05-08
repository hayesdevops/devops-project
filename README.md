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
│   └── networking/
├── aws/
│   ├── container/
│   └── networking/
└── azure/
    ├── container/
    └── networking/
```

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
