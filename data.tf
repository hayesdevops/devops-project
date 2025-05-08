# Fetch VPN shared key from AWS Secrets Manager
data "aws_secretsmanager_secret" "vpn_key" {
  provider = aws.shared
  name     = "vpn/shared-key" # Adjust name as needed
}

data "aws_secretsmanager_secret_version" "vpn_key" {
  provider  = aws.shared
  secret_id = data.aws_secretsmanager_secret.vpn_key.id
}
