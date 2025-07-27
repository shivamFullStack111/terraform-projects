resource "aws_lb" "my-LB" {                                           # Creates an Application Load Balancer (ALB) to distribute traffic across multiple targets like EC2 instances.
  name               = "my-LB"                                       # The name of the load balancer that will appear in the AWS console.
  internal           = false                                         # If set to false, the ALB is internet-facing (public); true means internal (private only within VPC).
  load_balancer_type = "application"                                 # Specifies the ALB type — "application" is used for HTTP/HTTPS (Layer 7) traffic.
  security_groups    = [aws_security_group.my-SG.id]                 # Attaches a security group to control allowed inbound/outbound traffic to the ALB.
  subnets            = [aws_subnet.subnet-ap-south-1a.id, aws_subnet.subnet-ap-south-1b.id]  # Places the ALB across 2 subnets (must be in different AZs for high availability).
  tags = {
    Environment = "production"                                       # Adds metadata tag to identify this ALB as part of the production environment.
  }
}

resource "aws_lb_listener" "LB-Listner" {                            # Defines a listener that checks for incoming requests on a specific port and protocol.
  load_balancer_arn = aws_lb.my-LB.arn                               # Attaches this listener to the previously created ALB using its ARN.
  port              = "80"                                           # The listener will listen for HTTP traffic on port 80 (standard web port).
  protocol          = "HTTP"                                         # Specifies that the listener uses the HTTP protocol (no SSL).

  default_action {                                                   # Defines what the listener should do when a request is received.
    type             = "forward"                                     # The action is to forward the traffic.
    target_group_arn = aws_lb_target_group.my-LB-target-group.arn   # Forwards traffic to the specified target group which includes EC2 instances or other targets.
  }
}
