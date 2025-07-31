resource "aws_vpc" "my-vpc" {
  cidr_block =var.vpc_cidr_block
  tags = {
    "Name" = var.vpc_name
  }
}

resource "aws_subnet" "subnets" {
  for_each = {for sub in var.subnets : sub.cidr_block=>sub}
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    "Name" = each.value.name 
  }
}

// filter and create list of all public subnets 
locals {
  public-subnets = [for sub in var.subnets: sub if sub.isPublic]
}

resource "aws_internet_gateway" "IGW" {
  count = length(local.public-subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    "Name" = "${var.vpc_name}-IGW" 
  }
}

resource "aws_route_table" "route_table" {
  count = length(local.public-subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.my-vpc.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW[0].id
  }
  tags = {
    "Name" = "route-table" 
  }
}

resource "aws_route_table_association" "table_association" {
  for_each = {for sub in local.public-subnets:sub.cidr_block=>sub}
  route_table_id = aws_route_table.route_table[0].id
  subnet_id = aws_subnet.subnets[each.value.cidr_block].id
}