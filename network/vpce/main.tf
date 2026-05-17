resource "aws_vpc_endpoint" "main" {
  for_each          = toset(var.services)
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.${each.value}"
  vpc_endpoint_type = contains(["s3", "dynamodb"], each.value) ? "Gateway" : "Interface"
  subnet_ids        = contains(["s3", "dynamodb"], each.value) ? null : var.subnet_ids
  security_group_ids = contains(["s3", "dynamodb"], each.value) ? null : [var.sg_id]
  private_dns_enabled = contains(["s3", "dynamodb"], each.value) ? false : true
  tags = merge(var.tags, {
    Name = "${var.account_name}-${var.environment}-vpce-${each.value}"
  })
}