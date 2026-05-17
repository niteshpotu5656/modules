data "aws_caller_identity" "current" {{}}

resource "aws_kms_key" "main" {
  description             = "${{var.account_name}}-${{var.environment}} KMS key"
  deletion_window_in_days = var.deletion_window
  enable_key_rotation     = true
  tags                    = var.tags
  policy = jsonencode({{
    Version = "2012-10-17"
    Statement = [
      {{
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {{ AWS = "arn:aws:iam::${{data.aws_caller_identity.current.account_id}}:root" }}
        Action   = "kms:*"
        Resource = "*"
      }},
      {{
        Sid    = "Allow Key Administrators"
        Effect = "Allow"
        Principal = {{ AWS = var.key_administrators }}
        Action   = ["kms:Create*","kms:Describe*","kms:Enable*","kms:List*","kms:Put*","kms:Update*","kms:Revoke*","kms:Disable*","kms:Get*","kms:Delete*","kms:ScheduleKeyDeletion","kms:CancelKeyDeletion"]
        Resource = "*"
      }}
    ]
  }})
}

resource "aws_kms_alias" "main" {
  name          = "alias/${{var.account_name}}-${{var.environment}}"
  target_key_id = aws_kms_key.main.key_id
}