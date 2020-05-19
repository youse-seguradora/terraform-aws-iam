provider "aws" {
  access_key                  = "mock_access_key"
  region                      = var.aws_region
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4567"
    cloudformation = "http://localhost:4581"
    cloudwatch     = "http://localhost:4582"
    dynamodb       = "http://localhost:4569"
    es             = "http://localhost:4578"
    firehose       = "http://localhost:4573"
    iam            = "http://localhost:4593"
    kinesis        = "http://localhost:4568"
    lambda         = "http://localhost:4574"
    route53        = "http://localhost:4580"
    redshift       = "http://localhost:4577"
    s3             = "http://localhost:4572"
    secretsmanager = "http://localhost:4584"
    ses            = "http://localhost:4579"
    sns            = "http://localhost:4575"
    sqs            = "http://localhost:4576"
    ssm            = "http://localhost:4583"
    stepfunctions  = "http://localhost:4585"
    sts            = "http://localhost:4592"
  }
}

#########################################
# IAM user with LoginProfile, Password and SSH Key
#########################################
module "iam_user1" {
  source = "../../modules/iam-user"

  name = var.iam_user_1_name

  # User "test" has uploaded his public key here - https://keybase.io/test/pgp_keys.asc
  pgp_key                 = "keybase:test"
  password_reset_required = false

  # SSH public key
  upload_iam_user_ssh_key = true
  ssh_public_key          = var.iam_user_1_ssh_public_key
}



###################################################################
# IAM user without login_profile and with SSH Key
# ###################################################################
module "iam_user2" {
  source = "../../modules/iam-user"

  name = var.iam_user_2_name

  create_iam_user_login_profile = false
}

###################################################################
# IAM user without login_profile ands SSH Key
# ###################################################################
module "iam_user3" {
  source = "../../modules/iam-user"

  name = var.iam_user_3_name

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

############
# Variables
############
variable "aws_region" {
  default = "us-east-1"
}
variable "iam_user_1_name" {}
variable "iam_user_1_ssh_public_key" {}
variable "iam_user_2_name" {}
variable "iam_user_3_name" {}
