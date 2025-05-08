resource "aws_s3_bucket" "logging" {
  bucket = "${var.state_bucket_name}-logs"

  tags = {
    Environment = var.environment
    Purpose     = "Terraform State Logging"
  }
}

resource "aws_s3_bucket_logging" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  target_bucket = aws_s3_bucket.logging.id
  target_prefix = "log/"
}
