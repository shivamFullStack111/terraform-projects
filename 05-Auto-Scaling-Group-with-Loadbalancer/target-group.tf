resource "aws_lb_target_group" "my-LB-target-group" {          # Creates a Target Group for the Load Balancer to route traffic to registered targets (e.g., EC2 instances).
  name     = "my-LB-target-group"                              # Name of the target group, visible in the AWS console.
  port     = 80                                                # The port on which the targets (EC2 instances) receive traffic — usually 80 for HTTP.
  protocol = "HTTP"                                            # Protocol used for routing traffic to targets — HTTP in this case.
  vpc_id   = aws_vpc.my-vpc.id                                 # The VPC where the target group and EC2 instances exist.

  health_check {                                               # Configures health checks to determine which targets are healthy and can receive traffic.
    path                = "/"                                  # The path used by the ALB to check the health of instances — requests will be sent to http://<instance-ip>/.
    interval            = 30                                   # Time in seconds between each health check attempt.
    timeout             = 5                                    # Time (in seconds) to wait for a response before marking the check as failed.
    healthy_threshold   = 2                                    # Number of successful checks before marking the instance as healthy.
    unhealthy_threshold = 2                                    # Number of failed checks before marking the instance as unhealthy.
    matcher             = "200"                                # The HTTP status code that indicates a healthy response (200 OK in this case).
  }
}
