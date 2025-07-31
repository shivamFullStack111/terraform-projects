resource "aws_autoscaling_group" "ASG" {
  launch_template {
    id = aws_launch_template.launch_template.id
  }
  target_group_arns =  var.ASG_target_group_arn
  max_size                  = var.ASG_max_size
  min_size                  = var.ASG_min_size
  desired_capacity          = var.ASG_desired_capacity
  health_check_grace_period = var.ASG_health_check_grace_period
  health_check_type         = var.ASG_health_check_type
  force_delete              = var.ASG_force_delete
  vpc_zone_identifier       = var.ASG_vpc_zone_identifier 
}
