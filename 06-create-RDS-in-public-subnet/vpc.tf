resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "subnet-ap-south-1a" {
  vpc_id = aws_vpc.my-vpc.id 
  availability_zone = "ap-south-1a"
  cidr_block = "10.0.1.0/24"
  tags = {
    name = "subnet-ap-south-1a"
  }
}
resource "aws_subnet" "subnet-ap-south-1b" {
  vpc_id = aws_vpc.my-vpc.id 
  availability_zone = "ap-south-1b"
  cidr_block = "10.0.2.0/24"
  tags = {
    name = "subnet-ap-south-1b"
  }
}

resource "aws_internet_gateway" "my-internet-gateway" {
  vpc_id = aws_vpc.my-vpc.id 
  tags = {
    "Name" = "my-internet-gateway" 
  }
}

resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-internet-gateway.id
  }
  tags = {
    "Name" = "my-route-table" 
  }
}

resource "aws_route_table_association" "table-association-1" {
  subnet_id = aws_subnet.subnet-ap-south-1a.id
  route_table_id = aws_route_table.my-route-table.id
}

resource "aws_route_table_association" "table-association-2" {
  subnet_id = aws_subnet.subnet-ap-south-1b.id
  route_table_id = aws_route_table.my-route-table.id
}