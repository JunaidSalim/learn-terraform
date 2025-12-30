resource "aws_iam_user" "devops_user" {
  name = "devops_user"

  force_destroy = true
}

resource "aws_iam_user_policy_attachment" "admin_policy" {
  user = aws_iam_user.devops_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "devops_user_access_key" {
  user = aws_iam_user.devops_user.name
}

resource "aws_iam_user_login_profile" "devops_user_console_access" {
  user = aws_iam_user.devops_user.name
}