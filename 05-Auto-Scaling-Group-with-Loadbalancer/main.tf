terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_autoscaling_group" "my-ASG" {                                     # Creates an Auto Scaling Group (ASG) that manages EC2 instances automatically based on demand.
  name                      = "my-ASG"                                          # The name of the Auto Scaling Group.
  max_size                  = 3                                                 # Maximum number of EC2 instances that the ASG can scale up to.
  min_size                  = 1                                                 # Minimum number of instances that should always be running.
  health_check_grace_period = 300                                               # Wait time (in seconds) after launching before checking health — useful for boot time.
  health_check_type         = "ELB"                                             # Health check is based on the ALB (ELB) status rather than EC2 instance status.

  launch_template {                                                             # Specifies which launch template the ASG should use to create instances.
    id   = aws_launch_template.my-launch-template.id                            # Refers to the ID of the launch template resource defined separately.
  }

  desired_capacity    = 2                                                       # Desired number of instances to run at any given time (between min and max).
  force_delete        = true                                                    # Allows Terraform to delete the ASG even if it has running instances (useful for automation).
  vpc_zone_identifier = [aws_subnet.subnet-ap-south-1a.id, aws_subnet.subnet-ap-south-1a.id]  # Subnets (AZs) where EC2 instances will be launched; should be different AZs ideally.

  instance_maintenance_policy {                                                 # Controls how instance replacement is handled during updates or health failures.
    min_healthy_percentage = 90                                                 # During replacement, at least 90% of instances should stay healthy.
    max_healthy_percentage = 120                                                # At most 120% capacity (more than desired) can be temporarily run during updates.
  }

  target_group_arns = [aws_lb_target_group.my-LB-target-group.arn]             # Links the ASG with a Target Group so that instances register automatically with the Load Balancer.
}
