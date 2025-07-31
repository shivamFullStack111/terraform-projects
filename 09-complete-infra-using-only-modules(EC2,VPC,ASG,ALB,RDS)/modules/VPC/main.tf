resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr_block
  tags_all = {
    "Name" = "my-vpc"
  }
}

# create multiple subnets according variable list 
resource "aws_subnet" "subnets" {
  for_each          = { for sub in var.subnets : sub.cidr_block => sub }
  vpc_id            = aws_vpc.my-vpc.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  tags = {
    "Name" = each.value.name
  }
}

# create list of all public subnets 
locals {
  public_subnets = [for sub in var.subnets : sub if sub.isPublic]
}

# create IGW if public subnet is available in var.subnets 
resource "aws_internet_gateway" "IGW" {
  count = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.my-vpc.id 
  tags = {
    "Name" = "my-VPC"
  }
}

# create route table if public subnet is available 
resource "aws_route_table" "route_table" {
  count = length(local.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.my-vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW[0].id
  }
  tags = {
    "Name" = "route_table"
  }
}

# associationg all public subnets with internet gateway 
resource "aws_route_table_association" "associations" {
  for_each = {for sub in local.public_subnets:sub.cidr_block=>sub} 
  subnet_id =  aws_subnet.subnets[each.value.cidr_block].id
  route_table_id = aws_route_table.route_table[0].id
}

