data "aws_region" "current" {{}}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${{data.aws_region.current.name}}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids
  tags              = merge(var.tags, {{ Name = "${{var.account_name}}-${{var.environment}}-s3-vpce" }})
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${{data.aws_region.current.name}}.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.sg_id]
  private_dns_enabled = true
  tags                = merge(var.tags, {{ Name = "${{var.account_name}}-${{var.environment}}-ecr-api-vpce" }})
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${{data.aws_region.current.name}}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.sg_id]
  private_dns_enabled = true
  tags                = merge(var.tags, {{ Name = "${{var.account_name}}-${{var.environment}}-ecr-dkr-vpce" }})
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${{data.aws_region.current.name}}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = [var.sg_id]
  private_dns_enabled = true
  tags                = merge(var.tags, {{ Name = "${{var.account_name}}-${{var.environment}}-secretsmanager-vpce" }})
}