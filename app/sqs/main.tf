resource "aws_sqs_queue" "dlq" {{
  count                     = var.dlq_enabled ? 1 : 0
  name                      = "${{var.name}}-dlq${{var.fifo ? ".fifo" : ""}}"
  fifo_queue                = var.fifo
  kms_master_key_id         = var.kms_key_arn
  tags                      = merge(var.tags, {{ Name = "${{var.name}}-dlq" }})
}}

resource "aws_sqs_queue" "main" {{
  name                      = "${{var.name}}${{var.fifo ? ".fifo" : ""}}"
  fifo_queue                = var.fifo
  kms_master_key_id         = var.kms_key_arn
  redrive_policy            = var.dlq_enabled ? jsonencode({{
    deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
    maxReceiveCount     = var.max_receive_count
  }}) : null
  tags = merge(var.tags, {{ Name = var.name }})
}}