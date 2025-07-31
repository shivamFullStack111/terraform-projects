# creating target group 
resource "aws_lb_target_group" "target-group" {
  vpc_id = var.vpc_id
  name = "target-group" 
  port = 80 
  protocol = "HTTP" 
  health_check {
    healthy_threshold = 3 // if the 3 times health check healthy then final state is healthy
    unhealthy_threshold = 3 // if the 3 times health check unhealthy then final state is unhealthy
    matcher = "200" // if status code is 200 means healthy state
    path = "/"
    port = 80 
    protocol = "HTTP"
    timeout = 5 
    interval = 30 
  }
  tags = {
    "Name" = "target-group" 
  }
}

# creating Application Load Balancer
resource "aws_lb" "my-LB" {
    subnets = var.public-subnet-ids //public subnet ids 
    load_balancer_type = "application" 
    security_groups = [aws_security_group.my-SG.id] 
    internal = false 
}

#  loadbalancer listner
resource "aws_lb_listener" "LB-listner" {
  load_balancer_arn = aws_lb.my-LB.arn 
  protocol = "HTTP" 
  port = 80
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
} 
