resource "aws_vpc" "my-vpc" {                                             # Creates a Virtual Private Cloud (VPC) — a logically isolated network within AWS.
  cidr_block = "10.0.0.0/16"                                              # Defines the IP address range of the VPC (65,536 IPs from 10.0.0.0 to 10.0.255.255).
  tags = {
    "Name" = "my-vpc"                                                     # Tag to identify the VPC in the AWS console.
  }
}

resource "aws_subnet" "subnet-ap-south-1a" {                              # Creates a subnet in Availability Zone ap-south-1a.
  vpc_id            = aws_vpc.my-vpc.id                                   # Associates the subnet with the VPC created above.
  cidr_block        = "10.0.0.0/24"                                       # Subnet's IP range (256 IPs from 10.0.0.0 to 10.0.0.255).
  availability_zone = "ap-south-1a"                                       # Specifies the AZ where this subnet will reside.
  tags = {
    "key" = "subnet-ap-south-1a"                                          # Custom tag to identify this subnet.
  }
}

resource "aws_subnet" "subnet-ap-south-1b" {                              # Creates another subnet in a different AZ (for high availability).
  vpc_id            = aws_vpc.my-vpc.id                                   # Associates the subnet with the same VPC.
  cidr_block        = "10.0.1.0/24"                                       # Another subnet range (256 IPs from 10.0.1.0 to 10.0.1.255).
  availability_zone = "ap-south-1b"                                       # Placed in ap-south-1b AZ for redundancy and load balancing.
  tags = {
    "key" = "subnet-ap-south-1b"                                          # Custom tag to identify this subnet.
  }
}

resource "aws_internet_gateway" "my-IGW" {                                # Creates an Internet Gateway (IGW) to enable internet access for the VPC.
  vpc_id = aws_vpc.my-vpc.id                                              # Attaches the IGW to the VPC.
  tags = {
    "Name" = "my-IGW"                                                     # Name tag for easier identification.
  }
}

resource "aws_route_table" "my-route-table" {                             # Creates a route table that contains rules for routing traffic within the VPC.
  vpc_id = aws_vpc.my-vpc.id                                              # Associates the route table with the VPC.
  route {
    cidr_block = "0.0.0.0/0"                                              # Defines a default route (any destination IP).
    gateway_id = aws_internet_gateway.my-IGW.id                           # Sends internet-bound traffic to the Internet Gateway.
  }
  tags = {
    "Name" = "my-route-table"                                             # Name tag for the route table.
  }
}

resource "aws_route_table_association" "route-table-association-1" {     # Associates the route table with subnet-ap-south-1a.
  subnet_id      = aws_subnet.subnet-ap-south-1a.id                      # Subnet that will use the above route table.
  route_table_id = aws_route_table.my-route-table.id                     # ID of the route table being associated.
}

resource "aws_route_table_association" "route-table-association-2" {     # Associates the same route table with subnet-ap-south-1b.
  subnet_id      = aws_subnet.subnet-ap-south-1b.id                      # Subnet that will use the above route table.
  route_table_id = aws_route_table.my-route-table.id                     # Same route table shared by both public subnets.
}
