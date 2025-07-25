terraform {
  required_providers {
    aws={
      source = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "my-key" {
  key_name = "my-key"
  public_key = file("./my-key-pair.pub")
}

# create security block 
resource "aws_security_group" "my-security-group" {
  name = "my-sg"
  tags = {
    Name = "my-sg"
  }
}

# allow 80 inbounded rule for appache 
resource "aws_vpc_security_group_ingress_rule" "sg-ingress-80-rule" {
  security_group_id = aws_security_group.my-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# allow 22 inbounded rule for ssh 
resource "aws_vpc_security_group_ingress_rule" "sg-ingress-22-rule" {
  security_group_id = aws_security_group.my-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# allow all outbounded rule 
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# create EC2 instance and associate security group 
resource "aws_instance" "my-aws_instance" {
  ami = "ami-0d0ad8bb301edb745"
  instance_type = "t2.nano"
  vpc_security_group_ids = [ aws_security_group.my-security-group.id ]
  key_name = aws_key_pair.my-key.key_name
  user_data = file("./user_data.sh")
}
