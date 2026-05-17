resource "aws_subnet" "public" {
  count             = length(var.public_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.public_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    Name = "${{var.account_name}}-${{var.environment}}-public-${{count.index + 1}}"
    Tier = "public"
  })
}

resource "aws_subnet" "private" {
  count             = length(var.private_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = merge(var.tags, {
    Name = "${{var.account_name}}-${{var.environment}}-private-${{count.index + 1}}"
    Tier = "private"
  })
}

resource "aws_subnet" "db" {
  count             = length(var.db_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.db_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = merge(var.tags, {
    Name = "${{var.account_name}}-${{var.environment}}-db-${{count.index + 1}}"
    Tier = "db"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id
  tags   = merge(var.tags, { Name = "${{var.account_name}}-${{var.environment}}-igw" })
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = merge(var.tags, { Name = "${{var.account_name}}-${{var.environment}}-public-rt" })
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}