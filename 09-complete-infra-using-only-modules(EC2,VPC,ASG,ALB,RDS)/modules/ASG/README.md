# ⚙️ Auto Scaling Group (ASG) Module

This module launches EC2 instances using a Launch Template inside an Auto Scaling Group behind an ALB.

---

## 📥 Input Variables

```hcl
variable "instance_type" {
  type = string
}

variable "image_id" {
  type = string
}

variable "associate_public_ip_address" {
  type = bool
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}
``` 

## Example usage 

module "ASG-module" {
  source                      = "./modules/ASG"
  instance_type               = "t3.micro"
  image_id                    = "ami-0d0ad8bb301edb745"
  vpc_id                      = module.VPC-module.vpc_id
  public_subnet_ids           = module.VPC-module.public-subnet-ids
  target_group_arn            = module.ALB-module.target_group_arn
  associate_public_ip_address = true
}

