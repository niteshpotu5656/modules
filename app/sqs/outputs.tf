output "queue_url" { value = aws_sqs_queue.main.url }
output "queue_arn" { value = aws_sqs_queue.main.arn }
output "dlq_arn"   { value = var.dlq_enabled ? aws_sqs_queue.dlq[0].arn : "" }