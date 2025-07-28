resource "aws_instance" "my-instance" {
  ami = "ami-0d0ad8bb301edb745"
  instance_type =  "t2.nano"
  subnet_id = aws_subnet.public-subnet.id 
  vpc_security_group_ids = [aws_security_group.SG.id]
  associate_public_ip_address = true
  tags = {
    "Name" = "my-instance" 
  }
}