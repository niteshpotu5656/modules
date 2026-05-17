data "aws_caller_identity" "current" {}

resource "aws_kms_key" "main" {
  description             = "${var.account_name}-${var.environment}-${var.purpose}"
  deletion_window_in_days = var.environment == "prod" ? 30 : 7
  enable_key_rotation     = true
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM Root Permissions"
        Effect = "Allow"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
  tags = merge(var.tags, {
    Name = "${var.account_name}-${var.environment}-${var.purpose}-kms"
  })
}

resource "aws_kms_alias" "main" {
  name          = "alias/${var.account_name}-${var.environment}-${var.purpose}"
  target_key_id = aws_kms_key.main.key_id
}