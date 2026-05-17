resource "aws_lb" "main" {{
  name               = var.name
  load_balancer_type = "network"
  internal           = var.internal
  subnets            = var.subnet_ids
  tags               = merge(var.tags, {{ Name = var.name }})
}}

resource "aws_lb_target_group" "main" {{
  name     = "${{var.name}}-tg"
  port     = var.target_port
  protocol = "TCP"
  vpc_id   = var.vpc_id
  tags     = merge(var.tags, {{ Name = "${{var.name}}-tg" }})
}}

resource "aws_lb_listener" "main" {{
  load_balancer_arn = aws_lb.main.arn
  port              = var.target_port
  protocol          = "TCP"
  default_action {{
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }}
}}