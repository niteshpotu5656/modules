resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${{data.aws_region.current.name}}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.sg_id]
  private_dns_enabled = true
  tags = merge(var.tags, {{ Name = "${{var.account_name}}-${{var.environment}}-ssm-endpoint" }})
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${{data.aws_region.current.name}}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.sg_id]
  private_dns_enabled = true
  tags = merge(var.tags, {{ Name = "${{var.account_name}}-${{var.environment}}-ssmmessages-endpoint" }})
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${{data.aws_region.current.name}}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.sg_id]
  private_dns_enabled = true
  tags = merge(var.tags, {{ Name = "${{var.account_name}}-${{var.environment}}-ec2messages-endpoint" }})
}

data "aws_region" "current" {{}}