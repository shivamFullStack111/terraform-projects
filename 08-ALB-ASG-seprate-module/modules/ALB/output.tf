output "security_group_id" {
  value = aws_security_group.my-SG.id
}

output "target_group_arn" {
  value = aws_lb_target_group.LB-target-group.arn
}