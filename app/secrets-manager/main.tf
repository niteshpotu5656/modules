resource "aws_secretsmanager_secret" "main" {
  name                    = "${var.account_name}/${var.environment}/${var.secret_name}"
  kms_key_id              = var.kms_key_arn
  recovery_window_in_days = var.environment == "prod" ? 30 : 7
  tags                    = merge(var.tags, { Name = "${var.account_name}-${var.environment}-${var.secret_name}" })
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = var.secret_value
}