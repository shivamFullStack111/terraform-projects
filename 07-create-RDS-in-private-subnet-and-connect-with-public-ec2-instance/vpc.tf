resource "aws_vpc" "my-vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
     "Name" ="my-vpc" 
   }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id = aws_vpc.my-vpc.id 
  cidr_block = "10.0.10.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    "Name" = "private-subnet" 
  }
}

resource "aws_subnet" "private-subnet-2" {
  availability_zone = "ap-south-1b"
  vpc_id = aws_vpc.my-vpc.id 
  cidr_block = "10.0.8.0/24"
  tags = {
    "Name" = "private-subnet" 
  }
}

resource "aws_subnet" "public-subnet" {
  availability_zone = "ap-south-1a"
  vpc_id = aws_vpc.my-vpc.id 
  cidr_block = "10.0.27.0/24"
  tags = {
    "Name" = "public-subnet" 
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "IGW"
  }
}


resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.my-vpc.id 
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

   tags = {
    Name = "route-table"
  }
}


resource "aws_route_table_association" "route-table-association" {
  subnet_id = aws_subnet.public-subnet.id 
  route_table_id = aws_route_table.route-table.id
}
