{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": [
        "iam:UpdateAccessKey",
        "iam:ListAccessKeys",
        "iam:GetUser",
        "iam:GetAccessKeyLastUsed",
        "iam:DeleteAccessKey",
        "iam:CreateAccessKey"
      ],
      "Resource": "arn:aws:iam::${aws_account}:user/$${aws:username}",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}