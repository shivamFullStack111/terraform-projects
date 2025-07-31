# creating launch template 
resource "aws_launch_template" "Launch-template" {
  image_id               = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [] //  no need if we provide SG in network_interface block
  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = [aws_security_group.my-SG.id]
  }
  user_data = base64encode(<<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
  )
  tags = {
    "Name" = "ASG-instance"
  }
}

resource "aws_autoscaling_group" "ASG" {
  desired_capacity          = 2
  force_delete              = true
  health_check_type         = "ELB"
  health_check_grace_period = 300 # mtlb jab ASG create ho uske 5 minutes baad health check krna he kyuki EC2 create hone and command run hone me time lgta he
  target_group_arns         = [var.target_group_arn]
  max_size                  = 3
  min_size                  = 1
  vpc_zone_identifier       = var.public_subnet_ids
  launch_template {
    id = aws_launch_template.Launch-template.id
  }
}
