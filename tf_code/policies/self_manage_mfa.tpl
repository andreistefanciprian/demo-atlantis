{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowUsersToCreateEnableResyncTheirOwnVirtualMFADevice",
      "Effect": "Allow",
      "Action": [
        "iam:ResyncMFADevice",
        "iam:EnableMFADevice",
        "iam:CreateVirtualMFADevice"
      ],
      "Resource": [
        "arn:aws:iam::${aws_account}:user/$${aws:username}",
        "arn:aws:iam::${aws_account}:mfa/$${aws:username}"
      ]
    },
    {
      "Sid": "AllowUsersToDeactivateTheirOwnVirtualMFADevice",
      "Effect": "Allow",
      "Action": "iam:DeactivateMFADevice",
      "Resource": [
        "arn:aws:iam::${aws_account}:user/$${aws:username}",
        "arn:aws:iam::${aws_account}:mfa/$${aws:username}"
      ],
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    },
    {
      "Sid": "AllowUsersToDeleteTheirOwnVirtualMFADevice",
      "Effect": "Allow",
      "Action": "iam:DeleteVirtualMFADevice",
      "Resource": [
        "arn:aws:iam::${aws_account}:user/$${aws:username}",
        "arn:aws:iam::${aws_account}:mfa/$${aws:username}"
      ],
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    },
    {
      "Sid": "AllowUsersToListMFADevicesandUsersForConsole",
      "Effect": "Allow",
      "Action": [
        "iam:ListVirtualMFADevices",
        "iam:ListUsers",
        "iam:ListMFADevices"
      ],
      "Resource": "*"
    }
  ]
}