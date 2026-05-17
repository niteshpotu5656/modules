resource "aws_cloudwatch_event_bus" "main" {
  count = var.create_custom_bus ? 1 : 0
  name  = "${var.account_name}-${var.environment}-${var.bus_name}"
  tags  = merge(var.tags, { Name = "${var.account_name}-${var.environment}-${var.bus_name}" })
}

resource "aws_cloudwatch_event_rule" "main" {
  for_each      = { for r in var.rules : r.name => r }
  name          = "${var.account_name}-${var.environment}-${each.key}"
  description   = each.value.description
  event_pattern = each.value.event_pattern
  event_bus_name = var.create_custom_bus ? aws_cloudwatch_event_bus.main[0].name : "default"
  state         = "ENABLED"
  tags          = merge(var.tags, { Name = "${var.account_name}-${var.environment}-${each.key}" })
}

resource "aws_cloudwatch_event_target" "main" {
  for_each       = { for r in var.rules : r.name => r }
  rule           = aws_cloudwatch_event_rule.main[each.key].name
  event_bus_name = var.create_custom_bus ? aws_cloudwatch_event_bus.main[0].name : "default"
  target_id      = "${each.key}-target"
  arn            = each.value.target_arn
  role_arn       = each.value.role_arn
}