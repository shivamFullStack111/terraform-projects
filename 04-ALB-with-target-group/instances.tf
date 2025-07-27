
# ----------- CREATE EC2 INSTANCE IN AP-SOUTH-1A FOR LOADBALANCER-----------------------------------
resource "aws_instance" "instance-ap-south-1a" {
  ami                         = "ami-0d0ad8bb301edb745"
  instance_type               = "t2.nano"
  vpc_security_group_ids      = [aws_security_group.my-SG.id]
  subnet_id                   = aws_subnet.subnet-ap-south-1a.id
  availability_zone           = aws_subnet.subnet-ap-south-1a.availability_zone
  associate_public_ip_address = true
  user_data                   = file("./user_data.sh")
  key_name                    = "new-key"
  tags = {
    Name = "instance-ap-south-1a"
  }
}
# ----------- CREATE EC2 INSTANCE IN AP-SOUTH-1B FOR LOADBALANCER--------------------------------------
resource "aws_instance" "instance-ap-south-1b" {
  ami                         = "ami-0d0ad8bb301edb745"
  instance_type               = "t2.nano"
  vpc_security_group_ids      = [aws_security_group.my-SG.id]
  subnet_id                   = aws_subnet.subnet-ap-south-1b.id
  availability_zone           = aws_subnet.subnet-ap-south-1b.availability_zone
  associate_public_ip_address = true
  user_data                   = file("./user_data.sh")
  key_name                    = "new-key"
  tags = {
    Name = "instance-ap-south-1b"
  }
}
