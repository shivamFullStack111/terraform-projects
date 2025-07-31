resource "aws_security_group" "my-SG" {
  vpc_id = var.vpc_id
  tags = {
    Name = "SG-for-RDS"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress-3306" {
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.my-SG.id
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "egress-all" {
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.my-SG.id
  ip_protocol       = "-1"
}
