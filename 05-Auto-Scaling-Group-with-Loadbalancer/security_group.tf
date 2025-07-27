resource "aws_security_group" "my-SG" {
  vpc_id = aws_vpc.my-vpc.id 
  tags = {
    "Name" = "my-SG" 
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress-22" {
  security_group_id = aws_security_group.my-SG.id 
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  to_port = 22 
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ingress-80" {
  security_group_id = aws_security_group.my-SG.id 
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "egress-all" {
  security_group_id = aws_security_group.my-SG.id 
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}