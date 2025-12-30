output "am_user_name" {
  value = aws_iam_user.devops_user.name
}

output "iam_user_password" {
  value = aws_iam_user_login_profile.devops_user_console_access.password
  sensitive = true
}

output "iam_user_access_key_id"{
    value = aws_iam_access_key.devops_user_access_key.id
}

output "iam_user_access_key_secret" {
  value = aws_iam_access_key.devops_user_access_key.secret
  sensitive = true
}