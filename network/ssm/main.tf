resource "aws_ssm_parameter" "main" {
  for_each = var.parameters
  name     = "/${var.account_name}/${var.environment}/${each.key}"
  type     = each.value.sensitive ? "SecureString" : "String"
  value    = each.value.value
  key_id   = each.value.sensitive ? var.kms_key_arn : null
  tags = merge(var.tags, {
    Name = "${var.account_name}-${var.environment}-${each.key}"
  })
}