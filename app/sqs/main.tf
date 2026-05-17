resource "aws_sqs_queue" "dlq" {
  count                     = var.create_dlq ? 1 : 0
  name                      = "${var.account_name}-${var.environment}-${var.queue_name}-dlq"
  kms_master_key_id         = var.kms_key_arn
  message_retention_seconds = 1209600
  tags                      = merge(var.tags, { Name = "${var.account_name}-${var.environment}-${var.queue_name}-dlq" })
}

resource "aws_sqs_queue" "main" {
  name                       = "${var.account_name}-${var.environment}-${var.queue_name}"
  visibility_timeout_seconds = var.visibility_timeout
  message_retention_seconds  = var.message_retention
  kms_master_key_id          = var.kms_key_arn

  redrive_policy = var.create_dlq ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
    maxReceiveCount     = var.max_receive_count
  }) : null

  tags = merge(var.tags, { Name = "${var.account_name}-${var.environment}-${var.queue_name}" })
}