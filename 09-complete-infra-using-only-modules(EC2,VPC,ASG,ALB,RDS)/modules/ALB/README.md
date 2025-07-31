# 🌐 ALB Module

This module creates an internet-facing Application Load Balancer (ALB) in public subnets.

---

## 📥 Input Variables

```hcl
variable "vpc_id" {
  type = string
}

variable "public-subnet-ids" {
  type = list(string)
}
```

--- 

## Outputs 

output "target_group_arn" {
  value = aws_lb_target_group.my_tg.arn
}

## Example usage 

module "ALB-module" {
  source            = "./modules/ALB"
  vpc_id            = module.VPC-module.vpc_id
  public-subnet-ids = module.VPC-module.public-subnet-ids
}


