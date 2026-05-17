output "bus_arn"  { value = aws_cloudwatch_event_bus.main.arn }
output "rule_arn" { value = aws_cloudwatch_event_rule.main.arn }