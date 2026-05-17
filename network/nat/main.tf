resource "aws_eip" "nat" {
  count  = length(var.public_subnet_ids)
  domain = "vpc"
  tags = merge(var.tags, {
    Name = "${var.account_name}-${var.environment}-eip-${count.index + 1}"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id
  tags = merge(var.tags, {
    Name = "${var.account_name}-${var.environment}-igw"
  })
}

resource "aws_nat_gateway" "main" {
  count         = length(var.public_subnet_ids)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = var.public_subnet_ids[count.index]
  tags = merge(var.tags, {
    Name = "${var.account_name}-${var.environment}-nat-${count.index + 1}"
  })
  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnet_ids)
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index % length(aws_nat_gateway.main)].id
  }
  tags = merge(var.tags, {
    Name = "${var.account_name}-${var.environment}-rt-private-${count.index + 1}"
  })
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private[count.index].id
}