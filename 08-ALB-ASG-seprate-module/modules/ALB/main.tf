resource "aws_lb" "my-LB" {
  name               = var.LB_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.my-SG.id]
  subnets            = var.subnet_ids
  tags = {
    Name = "my-LB"
  }
}

# loadbalancer listner 
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.my-LB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.LB-target-group.arn
  }
}