resource "aws_lb" "main" {
  name               = "${var.account_name}-${var.environment}-${var.name}-nlb"
  internal           = var.internal
  load_balancer_type = "network"
  subnets            = var.subnet_ids

  enable_deletion_protection       = var.environment == "prod" ? true : false
  enable_cross_zone_load_balancing = true

  tags = merge(var.tags, { Name = "${var.account_name}-${var.environment}-${var.name}-nlb" })
}

resource "aws_lb_target_group" "main" {
  name        = "${var.account_name}-${var.environment}-${var.name}-tg"
  port        = var.target_port
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    protocol = "TCP"
    interval = 30
  }

  tags = merge(var.tags, { Name = "${var.account_name}-${var.environment}-${var.name}-tg" })
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.listener_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}