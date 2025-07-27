terraform {
  required_providers {
    aws ={
      source = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}


# ----------- CREATE LOADBALANCER--------------------------------------------------------
resource "aws_lb" "my-lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my-SG.id]
  subnets            = [aws_subnet.subnet-ap-south-1a.id, aws_subnet.subnet-ap-south-1b.id]
  tags = {
    Name = "my-lb"
  }
}

#----------------- ATTACH OUR LOADBALANCER WITH TARGET GROUP---------------------------------
resource "aws_lb_listener" "LB-listner" {
  load_balancer_arn = aws_lb.my-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-LB-target-group.arn
  }
}

