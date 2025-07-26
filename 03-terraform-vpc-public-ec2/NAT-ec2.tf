resource "aws_security_group" "NAT-ec2-SG" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "NAT-ec2-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "NAT-ec2-ingress-rule-22" {
  security_group_id = aws_security_group.NAT-ec2-SG.id
    cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all protocols and ports"
}

resource "aws_vpc_security_group_egress_rule" "NAT-ec2-egress-rule" {
  security_group_id = aws_security_group.NAT-ec2-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}




// create NAT ec2 instance
resource "aws_instance" "NAT-ec2-instance" {
  ami                         = "ami-022b58402848af996"
  instance_type               = "t2.nano"
  subnet_id                   = aws_subnet.public-subnet.id
  availability_zone           = aws_subnet.public-subnet.availability_zone
  source_dest_check           = false
  vpc_security_group_ids      = [aws_security_group.NAT-ec2-SG.id]
  associate_public_ip_address = true
  key_name                    = "new-key-pair"
  tags = {
    Name = "NAT-ec2-instance"
  }
}
