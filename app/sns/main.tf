resource "aws_sns_topic" "main" {
  name              = "${var.account_name}-${var.environment}-${var.topic_name}"
  kms_master_key_id = var.kms_key_arn
  tags              = merge(var.tags, { Name = "${var.account_name}-${var.environment}-${var.topic_name}" })
}

resource "aws_sns_topic_subscription" "main" {
  for_each  = { for s in var.subscriptions : s.endpoint => s }
  topic_arn = aws_sns_topic.main.arn
  protocol  = each.value.protocol
  endpoint  = each.value.endpoint
}