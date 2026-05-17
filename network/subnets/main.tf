resource "aws_subnet" "private" {
  count             = length(var.private_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(var.tags, {
    Name = "${var.account_name}-${var.environment}-private-${count.index + 1}"
    Tier = "private"
  })
}

resource "aws_subnet" "public" {
  count             = length(var.public_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.public_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = false
  tags = merge(var.tags, {
    Name = "${var.account_name}-${var.environment}-public-${count.index + 1}"
    Tier = "public"
  })
}