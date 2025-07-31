# 🗄️ RDS Module

This module provisions a MySQL RDS instance in private subnets for secure database deployment.

---

## 📥 Input Variables

```hcl
variable "vpc_id" {
  type = string
}

variable "private-subnet_ids-for-rds-subnet-group" {
  type = list(string)
}
```

## Outputs 

output "RDS-endpoint" {
  value = aws_db_instance.my-RDS-instance.endpoint
}

## Example Usage 

module "RDS-module" {
  source = "./modules/RDS"
  vpc_id = module.VPC-module.vpc_id
  private-subnet_ids-for-rds-subnet-group = module.VPC-module.private-subnet-ids
}

