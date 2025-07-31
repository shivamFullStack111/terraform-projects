# creating subnets group in this subnets RDS instance will create at least 2 private subnet have to pass 
resource "aws_db_subnet_group" "db-subnet-group" {
  name = "db-subnet-group"
  subnet_ids = var.private-subnet_ids-for-rds-subnet-group
  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "my-RDS-instance" {
  vpc_security_group_ids = [aws_security_group.my-SG.id]
  username               = "admin"
  password               = "shivam123"
  allocated_storage      = 20
  skip_final_snapshot    = true
  instance_class         = "db.t3.micro"
  db_name                = "mydb"
  engine_version         = "8.0"
  engine                 = "mysql"
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  publicly_accessible    = false
}
