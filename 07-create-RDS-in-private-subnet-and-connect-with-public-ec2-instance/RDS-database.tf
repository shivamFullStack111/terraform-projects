resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "rds-subnet-group"  # Ye RDS Subnet Group ka naam hai jo RDS instance ko kaunse subnets me launch karna chahiye ye batata hai.

  subnet_ids = [
    aws_subnet.private-subnet-1.id,  # Pehla private subnet jahan RDS launch ho sakta hai (multi-AZ setup ke liye zaroori).
    aws_subnet.private-subnet-2.id   # Dusra private subnet, ye high availability ke liye important hota hai (ek AZ fail ho to dusre me kaam kare).
  ]

  tags = {
    Name = "rds-subnet-group"  # Ye tag sirf identification ke liye hota hai AWS console me easily dikh jaye is group ka naam.
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10  # Ye batata hai ki RDS instance ko kitni disk space (in GB) chahiye. 10 GB minimum hota hai for MySQL.

  engine               = "mysql"  # Ye define karta hai ki kaunsa database engine use ho raha hai. Yahan MySQL hai.

  engine_version       = "5.7"  # Ye batata hai ki kaunsi version of MySQL chahiye. Stable aur widely used version hai.

  instance_class       = "db.t3.micro"  # Ye define karta hai ki kaunsa hardware configuration milega. t3.micro choti testing ke liye best aur cost-efficient hai.

  vpc_security_group_ids = [aws_security_group.SG.id]  # Ye security group define karta hai ki kaunse IPs ya resources RDS se connect kar sakte hain (jaise EC2).

  username             = "admin"  # Ye master database user ka naam hai jo sabse pehle create hota hai. Isse login karke naye users banaye ja sakte hain.

  password             = "shivam123"  # Master user ka password. Isse EC2 ya local client se connect karne ke liye use kiya jata hai.

  parameter_group_name = "default.mysql5.7"  # Ye predefined set of DB parameters ka group hai jo MySQL 5.7 ke liye optimized hota hai (timeouts, cache, etc.).

  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name  # Ye batata hai ki RDS instance kaunse subnets (private wale) me launch hoga.

  skip_final_snapshot  = true  # Agar true set kiya to jab DB delete hoga tab snapshot nahi banega (matlab koi backup nahi bachega) — useful in testing environment.
}
