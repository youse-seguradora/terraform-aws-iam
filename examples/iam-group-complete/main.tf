provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "us-east-1"
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localstack:4567"
    cloudformation = "http://localstack:4581"
    cloudwatch     = "http://localstack:4582"
    dynamodb       = "http://localstack:4569"
    es             = "http://localstack:4578"
    firehose       = "http://localstack:4573"
    iam            = "http://localstack:4593"
    kinesis        = "http://localstack:4568"
    lambda         = "http://localstack:4574"
    route53        = "http://localstack:4580"
    redshift       = "http://localstack:4577"
    s3             = "http://localstack:4572"
    secretsmanager = "http://localstack:4584"
    ses            = "http://localstack:4579"
    sns            = "http://localstack:4575"
    sqs            = "http://localstack:4576"
    ssm            = "http://localstack:4583"
    stepfunctions  = "http://localstack:4585"
    sts            = "http://localstack:4592"
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
