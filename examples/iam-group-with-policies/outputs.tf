output "this_group_1_name" {
  description = "IAM group name"
  value       = module.iam_group_1.this_group_name
}

output "this_group_1_users_names" {
  description = "List of IAM users in IAM group"
  value       = module.iam_group_1.this_group_users
}

output "this_group_2_name" {
  description = "IAM group name"
  value       = module.iam_group_2.this_group_name
}

output "this_group_2_users_names" {
  description = "List of IAM users in IAM group"
  value       = module.iam_group_2.this_group_users
}
