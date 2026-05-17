resource "aws_lb" "main" {{
  name               = var.name
  load_balancer_type = "application"
  internal           = var.internal
  subnets            = var.subnet_ids
  security_groups    = var.sg_ids
  tags               = merge(var.tags, {{ Name = var.name }})
}}

resource "aws_lb_target_group" "main" {{
  name     = "${{var.name}}-tg"
  port     = var.target_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {{
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 3
    interval            = 30
  }}
  tags = merge(var.tags, {{ Name = "${{var.name}}-tg" }})
}}

resource "aws_lb_listener" "main" {{
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"
  default_action {{
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }}
}}