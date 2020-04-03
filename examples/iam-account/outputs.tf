output "this_caller_identity_account_id" {
  description = "The ID of the AWS account"
  value       = module.iam_account.this_caller_identity_account_id
}

output "this_iam_account_password_policy_max_password_age" {
  value       = module.iam_account.this_iam_account_password_policy_max_password_age
}

output "this_iam_account_password_policy_minimum_password_length" {
  value       = module.iam_account.this_iam_account_password_policy_minimum_password_length
}

output "this_iam_account_password_policy_password_reuse_prevention" {
  value       = module.iam_account.this_iam_account_password_policy_password_reuse_prevention
}

output "this_iam_account_password_policy_require_lowercase_characters" {
  value       = module.iam_account.this_iam_account_password_policy_require_lowercase_characters
}

output "this_iam_account_password_policy_require_uppercase_characters" {
  value       = module.iam_account.this_iam_account_password_policy_require_uppercase_characters
}

output "this_iam_account_password_policy_require_numbers" {
  value       = module.iam_account.this_iam_account_password_policy_require_numbers
}

output "this_iam_account_password_policy_require_symbols" {
  value       = module.iam_account.this_iam_account_password_policy_require_symbols
}
