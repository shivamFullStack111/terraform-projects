
# ----------------CREATE TARGET GROUP AND ALSO INCLUDE HEALTH CHECK ---------------------------
resource "aws_lb_target_group" "my-LB-target-group" {
  name     = "my-LB-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my-vpc.id
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# --------------ATTACH OUR AP-SOUTH-1A EC2 INSTANCE WITH TARGET GROUP----------------------------------
resource "aws_lb_target_group_attachment" "TG-attach1" {
  target_group_arn = aws_lb_target_group.my-LB-target-group.arn
  target_id        = aws_instance.instance-ap-south-1a.id
  port             = 80
}

# --------------ATTACH OUR AP-SOUTH-1B EC2 INSTANCE WITH TARGET GROUP----------------------------------
resource "aws_lb_target_group_attachment" "TG-attach2" {
  target_group_arn = aws_lb_target_group.my-LB-target-group.arn
  target_id        = aws_instance.instance-ap-south-1b.id
  port             = 80
}

