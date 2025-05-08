output "aws_state_bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "aws_dynamodb_table" {
  value = aws_dynamodb_table.terraform_lock.name
}

output "azure_storage_account" {
  value = azurerm_storage_account.terraform_state.name
}

output "azure_container_name" {
  value = azurerm_storage_container.terraform_state.name
}
