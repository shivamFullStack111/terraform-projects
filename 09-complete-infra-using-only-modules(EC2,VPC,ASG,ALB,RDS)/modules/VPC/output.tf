output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

output "subnets" {
  value = aws_subnet.subnets
}

output "private-subnet-ids" {
  value = [for sub in var.subnets : aws_subnet.subnets[sub.cidr_block].id if !sub.isPublic]
}

output "public-subnet-ids" {
  value = [for sub in var.subnets : aws_subnet.subnets[sub.cidr_block].id if sub.isPublic]
}
