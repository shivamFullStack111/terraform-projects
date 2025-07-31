output "target_group_id" {
  value = aws_lb_target_group.target-group.id
}
output "target_group_arn" {
  value = aws_lb_target_group.target-group.arn
}

output "LoadBalancer_id" {
  value = aws_lb.my-LB.id
}
output "LoadBalancer_arn" {
  value = aws_lb.my-LB.arn
}