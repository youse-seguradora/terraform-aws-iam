output "this_caller_identity_account_id" {
  description = "The AWS Account ID number of the account that owns or contains the calling entity"
  value       = element(concat(data.aws_caller_identity.this.*.account_id, [""]), 0)
}

output "this_caller_identity_arn" {
  description = "The AWS ARN associated with the calling entity"
  value       = element(concat(data.aws_caller_identity.this.*.arn, [""]), 0)
}

output "this_caller_identity_user_id" {
  description = "The unique identifier of the calling entity"
  value       = element(concat(data.aws_caller_identity.this.*.user_id, [""]), 0)
}

output "this_iam_account_password_policy_expire_passwords" {
  description = "Indicates whether passwords in the account expire. Returns true if max_password_age contains a value greater than 0. Returns false if it is 0 or not present."
  value       = element(concat(aws_iam_account_password_policy.this.*.expire_passwords, [""]), 0)
}

output "this_iam_account_password_policy_max_password_age" {
  description = "Indicates the max age of passwords in IAM user."
  value       = element(concat(aws_iam_account_password_policy.this.*.max_password_age, [""]), 0)
}

output "this_iam_account_password_policy_minimum_password_length" {
  description = "Indicates the minimum passwords length for IAM user."
  value       = element(concat(aws_iam_account_password_policy.this.*.minimum_password_length, [""]), 0)
}

output "this_iam_account_password_policy_allow_users_to_change_password" {
  description = "Indicates if IAM user is allowed to changer their passwords."
  value       = element(concat(aws_iam_account_password_policy.this.*.minimum_password_length, [""]), 0)
}

output "this_iam_account_password_policy_password_reuse_prevention" {
  description = "The number of previous passwords that users are prevented from reusing."
  value       = element(concat(aws_iam_account_password_policy.this.*.password_reuse_prevention, [""]), 0)
}

output "this_iam_account_password_policy_require_lowercase_characters" {
  description = "Whether to require lowercase characters for user passwords."
  value       = element(concat(aws_iam_account_password_policy.this.*.require_lowercase_characters, [""]), 0)
}

output "this_iam_account_password_policy_require_uppercase_characters" {
  description = "Whether to require uppercase characters for user passwords."
  value       = element(concat(aws_iam_account_password_policy.this.*.require_uppercase_characters, [""]), 0)
}

output "this_iam_account_password_policy_require_numbers" {
  description = "Whether to require numbers for user passwords."
  value       = element(concat(aws_iam_account_password_policy.this.*.require_numbers, [""]), 0)
}

output "this_iam_account_password_policy_require_symbols" {
  description = "Whether to require symbols for user passwords."
  value       = element(concat(aws_iam_account_password_policy.this.*.require_symbols, [""]), 0)
}
