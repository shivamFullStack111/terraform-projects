resource "aws_security_group" "private-ec2-SG" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "private-ec2-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "private-ec2-ingress-rule" {
  security_group_id = aws_security_group.private-ec2-SG.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
}
resource "aws_vpc_security_group_egress_rule" "private-ec2-egress-rule-22" {
  security_group_id = aws_security_group.private-ec2-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

// create private ec2 instance
resource "aws_instance" "private-ec2-instance" {
  ami                         = "ami-0d0ad8bb301edb745"
  instance_type               = "t2.nano"
  availability_zone = aws_subnet.private-subnet.availability_zone
  subnet_id                   = aws_subnet.private-subnet.id
  vpc_security_group_ids      = [aws_security_group.private-ec2-SG.id]
  associate_public_ip_address = false
  key_name                    = "new-key-pair"
  tags = {
    Name = "private-ec2-instance"
  }
}
