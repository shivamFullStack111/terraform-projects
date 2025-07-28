# How to check the RDS is working or not 

1. connect ec2 instance using ssh 
2. RUN: sudo yum update -y
3. RUN: sudo yum install telnet -y 
4. RUN: telnet RDS_ENDPOINT 3306

# output. 

*if the output is*

Connected to terraform-...
Escape character is '^]'.

thats mean your RDS is up and rechable

