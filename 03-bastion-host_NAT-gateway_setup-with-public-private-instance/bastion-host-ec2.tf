resource "aws_security_group" "bastion-ec2-SG" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "bastion-ec2-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "bastion-ec2-ingress-rule-22" {
  security_group_id = aws_security_group.bastion-ec2-SG.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "bastion-ec2-ingress-rule-80" {
  security_group_id = aws_security_group.bastion-ec2-SG.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
}
resource "aws_vpc_security_group_egress_rule" "bastion-ec2-egress-rule" {
  security_group_id = aws_security_group.bastion-ec2-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

// create bastion ec2 instance
resource "aws_instance" "bastion-ec2-instance" {
  ami                         = "ami-0d0ad8bb301edb745"
  instance_type               = "t2.nano"
  subnet_id                   = aws_subnet.public-subnet.id
  availability_zone = aws_subnet.public-subnet.availability_zone
  vpc_security_group_ids      = [aws_security_group.bastion-ec2-SG.id]
  associate_public_ip_address = true
  key_name                    = "new-key-pair"
  tags = {
    Name = "bastion-ec2-instance"
  }
}
