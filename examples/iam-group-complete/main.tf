provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "us-east-1"
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    es             = "http://localhost:4566"
    firehose       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    kinesis        = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    route53        = "http://localhost:4566"
    redshift       = "http://localhost:4566"
    s3             = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
    ses            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
    stepfunctions  = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
}

############
# IAM users
############
module "iam_user1" {
  source = "../../modules/iam-user"

  name = var.iam_user_1_name

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "iam_user2" {
  source = "../../modules/iam-user"

  name = var.iam_user_2_name

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

variable "iam_user_1_name" {}
variable "iam_user_2_name" {}

#############################################################################################
# IAM group where user1 and user2 are allowed to assume admin role in production AWS account
#############################################################################################
module "iam_group_complete" {
  source = "../../modules/iam-group-with-assumable-roles-policy"

  name = var.iam_group_name

  assumable_roles = ["arn:aws:iam::111111111111:role/admin"]

  group_users = [
    module.iam_user1.this_iam_user_name,
    module.iam_user2.this_iam_user_name,
  ]
}

variable "iam_group_name" {}

####################################################
# Extending policies of IAM group production-admins
####################################################
module "iam_group_complete_with_custom_policy" {
  source = "../../modules/iam-group-with-policies"

  name = module.iam_group_complete.group_name

  create_group = false

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ]
}
