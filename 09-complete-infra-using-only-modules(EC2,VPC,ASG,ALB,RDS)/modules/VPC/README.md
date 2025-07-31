# 🏗️ VPC Module

This module creates a custom VPC along with public and private subnets across multiple Availability Zones.

---

## 📥 Input Variables

```hcl
variable "vpc_cidr_block" {
  type = string
}

variable "subnets" {
  type = list(object({
    availability_zone = string
    cidr_block        = string
    name              = string
    isPublic          = optional(bool, false)
  }))
}
```

---

## Outputs

output "vpc_id" {
value = aws_vpc.my-vpc.id
}

output "subnets" {
value = aws_subnet.subnets
}

output "public-subnet-ids" {
value = [for sub in var.subnets : aws_subnet.subnets[sub.cidr_block].id if sub.isPublic]
}

output "private-subnet-ids" {
value = [for sub in var.subnets : aws_subnet.subnets[sub.cidr_block].id if !sub.isPublic]
}

## example Usage

module "VPC-module" {
source = "./modules/VPC"
vpc_cidr_block = "10.0.0.0/16"
subnets = [
{
availability_zone = "ap-south-1a"
cidr_block = "10.0.0.0/24"
name = "private-subnet-1"
},
{
availability_zone = "ap-south-1b"
cidr_block = "10.0.3.0/24"
name = "private-subnet-2"
},
{
availability_zone = "ap-south-1b"
cidr_block = "10.0.1.0/24"
name = "public-subnet-1"
isPublic = true
},
{
availability_zone = "ap-south-1c"
cidr_block = "10.0.2.0/24"
name = "public-subnet-2"
isPublic = true
}
]
}
