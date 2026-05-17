resource "aws_sns_topic" "main" {{
  name              = var.name
  kms_master_key_id = var.kms_key_arn
  tags              = merge(var.tags, {{ Name = var.name }})
}}