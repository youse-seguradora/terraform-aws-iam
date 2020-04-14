provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "us-east-1"
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    iam            = "http://localstack:4593"
  }
}

##############
# IAM account
##############
module "iam_account" {
  source = "../../modules/iam-account"

  account_alias = var.iam_account_alias

  max_password_age               = var.iam_max_password_age
  minimum_password_length        = var.iam_minimum_password_length
  password_reuse_prevention      = var.iam_password_reuse_prevention
  allow_users_to_change_password = true
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
}

variable "iam_max_password_age" {}
variable "iam_account_alias" {}
variable "iam_minimum_password_length" {}
variable "iam_password_reuse_prevention" {}
