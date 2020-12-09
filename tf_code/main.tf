variable "name" {
  type    = string
  default = "self-manage"
}

variable "region" {
  default = "us-east-1"
}

provider "aws" {
  version = "~> 3.0"
  region  = var.region
  profile = "default"
}

# create IAM MFA group
resource "aws_iam_group" "self_manage" {
  name = var.name
}

# get current aws account id
data "aws_caller_identity" "current" {}

# create IAM policies
resource "aws_iam_policy" "self_manage_key" {
  name        = "${var.name}_self_manage_key"
  description = "Allow users to manage their own access keys"
  policy      = templatefile("tf_code/policies/self_manage_key.tpl", { aws_account = data.aws_caller_identity.current.account_id })
}

resource "aws_iam_policy" "self_manage_password" {
  name        = "${var.name}_self_manage_password"
  description = "Allow users to change their own passwords"
  policy      = templatefile("tf_code/policies/self_manage_password.tpl", { aws_account = data.aws_caller_identity.current.account_id })
}

resource "aws_iam_policy" "self_manage_mfa" {
  name        = "${var.name}_self_manage_mfa"
  description = "Allow users to manage their own MFA"
  policy      = templatefile("tf_code/policies/self_manage_mfa.tpl", { aws_account = data.aws_caller_identity.current.account_id })
}

# associate IAM policies with IAM group
resource "aws_iam_group_policy_attachment" "self_manage_mfa" {
  group      = aws_iam_group.self_manage.name
  policy_arn = aws_iam_policy.self_manage_key.arn
}

resource "aws_iam_group_policy_attachment" "self_manage_password" {
  group      = aws_iam_group.self_manage.name
  policy_arn = aws_iam_policy.self_manage_password.arn
}

resource "aws_iam_group_policy_attachment" "self_manage_key" {
  group      = aws_iam_group.self_manage.name
  policy_arn = aws_iam_policy.self_manage_mfa.arn
}

# write to ssm param store
resource "aws_ssm_parameter" "self_manage_group_name" {
  name  = "/${var.name}/self_manage_group_name"
  type  = "String"
  value = aws_iam_group.self_manage.name
}

# resource "null_resource" "example" {}

# outputs
output "self_manage_group_name" {
  description = "Name of IAM group"
  value       = aws_iam_group.self_manage.name
}
