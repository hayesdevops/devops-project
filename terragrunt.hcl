remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "terraform-state-bucket"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

inputs = {
  environment = get_env("TF_VAR_environment", "prod")
  cost_center = get_env("TF_VAR_cost_center", "devops-infrastructure")
  owner       = get_env("TF_VAR_owner", "platform-team")
}
