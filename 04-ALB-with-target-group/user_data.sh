#!/bin/bash

sudo yum update -y
sudo yum install httpd -y 

sudo systemctl enable httpd 
sudo systemctl start httpd 

echo "server is running on port $(hostname)" > /var/www/html/index.html
 