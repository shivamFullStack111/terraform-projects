output "vpc" {
  value = aws_vpc.my-vpc
}

output "public-subnet" {
  value = aws_subnet.my-public-subnet
}

output "private-subnet" {
  value = aws_subnet.my-private-subnet
}

output "internet_gateway" {
  value = aws_internet_gateway.my_internet_gateway
}

output "route-table" {
  value = aws_route_table.my-route-table
}

output "route-table-association" {
  value = aws_route_table_association.route_table_association
}

output "instance" {
  value = aws_instance.my_instance
}