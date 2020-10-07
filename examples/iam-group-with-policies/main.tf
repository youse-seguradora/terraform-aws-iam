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

#####################################################################################
# IAM group for superadmins with full Administrator access
#####################################################################################
module "iam_group_1" {
  source = "../../modules/iam-group-with-policies"

  name = var.iam_group_name_1

  group_users = [
    module.iam_user1.this_iam_user_name,
    module.iam_user2.this_iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}

variable "iam_group_name_1" {}

#####################################################################################
# IAM group for users with custom access
#####################################################################################
module "iam_group_2" {
  source = "../../modules/iam-group-with-policies"

  name = var.iam_group_name_2

  group_users = [
    module.iam_user1.this_iam_user_name,
    module.iam_user2.this_iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
    "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
  ]

  custom_group_policies = [
    {
      name   = "AllowS3Listing"
      policy = data.aws_iam_policy_document.sample.json
    },
  ]
}

variable "iam_group_name_2" {}

######################
# IAM policy (sample)
######################
data "aws_iam_policy_document" "sample" {
  statement {
    actions = [
      "s3:ListBuckets",
    ]

    resources = ["*"]
  }
}
