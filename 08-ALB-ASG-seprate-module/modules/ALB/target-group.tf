resource "aws_lb_target_group" "LB-target-group" {
  name     = "my-LB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
   health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}