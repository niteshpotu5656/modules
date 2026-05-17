resource "aws_cloudwatch_event_bus" "main" {{
  name = var.bus_name
  tags = merge(var.tags, {{ Name = var.bus_name }})
}}

resource "aws_cloudwatch_event_rule" "main" {{
  name           = var.rule_name
  event_bus_name = aws_cloudwatch_event_bus.main.name
  event_pattern  = var.event_pattern
  tags           = merge(var.tags, {{ Name = var.rule_name }})
}}

resource "aws_cloudwatch_event_target" "main" {{
  rule           = aws_cloudwatch_event_rule.main.name
  event_bus_name = aws_cloudwatch_event_bus.main.name
  target_id      = "main-target"
  arn            = var.target_arn
}}