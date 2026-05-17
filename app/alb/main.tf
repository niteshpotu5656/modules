resource "aws_lb" "main" {
  name               = "${var.account_name}-${var.environment}-${var.name}-alb"
  internal           = var.internal
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = var.sg_ids

  drop_invalid_header_fields = true
  enable_deletion_protection = var.environment == "prod" ? true : false

  access_logs {
    bucket  = var.log_bucket
    prefix  = "${var.account_name}/${var.environment}/${var.name}"
    enabled = true
  }

  tags = merge(var.tags, { Name = "${var.account_name}-${var.environment}-${var.name}-alb" })
}

resource "aws_lb_target_group" "main" {
  name        = "${var.account_name}-${var.environment}-${var.name}-tg"
  port        = var.target_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.health_check_path
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = merge(var.tags, { Name = "${var.account_name}-${var.environment}-${var.name}-tg" })
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener" "http_redirect" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}