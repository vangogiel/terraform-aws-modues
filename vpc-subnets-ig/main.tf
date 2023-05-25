resource "aws_vpc" "main" {
  cidr_block            = "10.0.0.0/16"
  enable_dns_support    = true
  enable_dns_hostnames  = true
  tags = {
    Name = "vpc-${var.environment}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  depends_on = [ 
    aws_vpc.main
  ]
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "vpc-${var.environment}-internet-gateway"
  }
}

resource "aws_subnet" "public_subnets" {
  depends_on = [ 
    aws_vpc.main 
  ]
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(local.azs, count.index)
  map_public_ip_on_launch = true
 
  tags = {
    Name = "public-${var.environment}-subnet-${count.index + 1}"
  }
}
 
resource "aws_subnet" "private_subnets" {
  depends_on = [ 
    aws_vpc.main 
  ]
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.private_subnet_cidrs, count.index)
  availability_zone       = element(local.azs, count.index)
  map_public_ip_on_launch = false
 
  tags = {
    Name = "private-${var.environment}-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "public" {
  depends_on = [ 
    aws_vpc.main 
  ]
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "public-${var.environment}-route-table"
  }
}

resource "aws_route_table" "private" {
  depends_on  = [ 
    aws_vpc.main 
  ]
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "private-${var.environment}-route-table"
  }
}

resource "aws_route" "public_route" {
  depends_on = [ 
    aws_route_table.public,
    aws_internet_gateway.internet_gateway 
  ]
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public" {
  depends_on = [ 
    aws_subnet.public_subnets,
    aws_route_table.public 
  ]
  count           = length(var.public_subnet_cidrs)
  subnet_id       = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id  = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  depends_on = [ 
    aws_route_table.private,
    aws_subnet.private_subnets,
  ]
  count           = length(var.private_subnet_cidrs)
  subnet_id       = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id  = aws_route_table.private.id
}
