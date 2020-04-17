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
