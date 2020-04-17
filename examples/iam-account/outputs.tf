output "this_iam_max_password_age" {
  value = module.iam_account.this_iam_account_password_policy_max_password_age
}

output "this_iam_minimum_password_length" {
  value = module.iam_account.this_iam_account_password_policy_minimum_password_length
}

output "this_iam_password_reuse_prevention" {
  value = module.iam_account.this_iam_account_password_policy_password_reuse_prevention
}

output "this_iam_allow_users_to_change_password" {
  value = module.iam_account.this_iam_account_password_policy_allow_users_to_change_password
}

output "this_iam_require_lowercase_characters" {
  value = module.iam_account.this_iam_account_password_policy_require_lowercase_characters
}

output "this_iam_require_uppercase_characters" {
  value = module.iam_account.this_iam_account_password_policy_require_uppercase_characters
}

output "this_iam_require_numbers" {
  value = module.iam_account.this_iam_account_password_policy_require_numbers
}

output "this_iam_require_symbols" {
  value = module.iam_account.this_iam_account_password_policy_require_symbols
}

output "this_account_alias" {
  value = module.iam_account.this_account_alias
}
