########################
# Getting Users Names
########################
output "this_iam_user_name1" {
  value = module.iam_user1.this_iam_user_name
}
output "this_iam_user_name2" {
  value = module.iam_user2.this_iam_user_name
}

output "this_iam_user_name3" {
  value = module.iam_user3.this_iam_user_name
}
