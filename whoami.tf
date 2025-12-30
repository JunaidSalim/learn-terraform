data "aws_caller_identity" "current_user" {
}

output "current_user_arn" {
  value = data.aws_caller_identity.current_user.arn
}