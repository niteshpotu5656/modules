resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  transit_gateway_id = var.tgw_id
  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  tags = merge(var.tags, {
    Name = "${var.account_name}-${var.environment}-tgw-attachment"
  })
}

data "aws_ec2_transit_gateway_route_table" "main" {
  filter {
    name   = "transit-gateway-id"
    values = [var.tgw_id]
  }
  filter {
    name   = "default-association-route-table"
    values = ["true"]
  }
}

resource "aws_ec2_transit_gateway_route" "static" {
  count                          = length(var.static_routes)
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway_route_table.main.id
  destination_cidr_block         = var.static_routes[count.index]
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main.id
}