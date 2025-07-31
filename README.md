# Complete AWS Infrastructure Using Terraform Modules

This project provisions a complete AWS infrastructure using Terraform modules. It includes modules for VPC, ALB (Application Load Balancer), ASG (Auto Scaling Group), and RDS (Relational Database Service).

---

## 🚀 Project Overview

- Create a custom VPC with public and private subnets
- Setup an internet-facing ALB in public subnets
- Deploy EC2 instances using Auto Scaling Group behind the ALB
- Provision a MySQL RDS instance in private subnets

---

## 🗂️ Project Structure

09-complete-infra-using-only-modules/
├── main.tf # Root Terraform configuration 
├── variables.tf # Root variables (optional)
├── outputs.tf # Root outputs (optional)
├── README.md # This project overview README
└── modules/
      ├── VPC/ # VPC module
      ├── ALB/ # ALB module
      ├── ASG/ # ASG module
      └── RDS/ # RDS module


## Run 

terraform init 
terraform plan
terraform apply
terraform destroy
