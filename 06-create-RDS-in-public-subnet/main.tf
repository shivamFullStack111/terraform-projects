terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "main"
  subnet_ids = [aws_subnet.subnet-ap-south-1a.id, aws_subnet.subnet-ap-south-1b.id]
  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "mydb" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  db_name                = "students"
  password               = "shivam123"
  vpc_security_group_ids = [aws_security_group.my-SG.id]
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name

  skip_final_snapshot = true
  publicly_accessible = false
  tags = {
    Name = "mydb"
  }
}


