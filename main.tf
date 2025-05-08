
# Deploy AWS Shared Services Network
module "aws_shared_network" {
  source = "./modules/aws/networking"
  providers = {
    aws = aws.shared
  }

  environment         = "shared"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "us-west-2a"
  amazon_side_asn     = 64512
}

# Deploy AWS Production Network
module "aws_prod_network" {
  source = "./modules/aws/networking"
  providers = {
    aws = aws.prod
  }

  vpc_cidr            = "10.1.0.0/16"
  public_subnet_cidr  = "10.1.1.0/24"
  private_subnet_cidr = "10.1.2.0/24"
  availability_zone   = "us-west-2a"
  transit_gateway_id  = module.aws_shared_network.transit_gateway_id
}

# Deploy Azure Network
module "azure_network" {
  source = "./modules/azure/networking"

  vnet_address_space      = "172.16.0.0/16"
  container_subnet_prefix = "172.16.1.0/24"
  transit_subnet_prefix   = "172.16.2.0/24"
  vpn_client_address_pool = "172.17.0.0/24"

  aws_transit_gateway_vpn_ip = module.aws_shared_network.vpn_endpoint_ip
  aws_address_space          = module.aws_prod_network.vpc_cidr
  vpn_shared_key             = data.aws_secretsmanager_secret_version.vpn_key.secret_string
}

module "aws_container" {
  source = "./modules/aws/container"
  providers = {
    aws = aws.prod
  }

  subnet_ids = module.aws_prod_network.private_subnet_id
}

# Deploy Azure Container
module "azure_container" {
  source              = "./modules/azure/container"
  container_subnet_id = module.azure_network.container_subnet_id
}