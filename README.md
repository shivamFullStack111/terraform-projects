# 🌐 AWS Auto Scaling Infrastructure with ALB using Terraform

This project builds a **highly available, fault-tolerant, and auto-scalable** infrastructure on **AWS using Terraform**. It uses an Application Load Balancer (ALB) to distribute HTTP traffic across EC2 instances managed by an Auto Scaling Group (ASG), all deployed in a custom VPC with public subnets.

---

## 📌 Features

- 🌍 Custom VPC with two public subnets in different Availability Zones (AZs)
- 🔐 Internet Gateway and route table for public internet access
- 🚀 Launch Template for EC2 instances with startup script (user data)
- ⚖️ Application Load Balancer (ALB) with target group and listener
- 🔄 Auto Scaling Group (ASG) linked to ALB with health checks and scaling policies
- 📈 Fully automated and reusable Terraform configuration

---

## 📦 Tech Stack

| Tool/Service     | Purpose                        |
|------------------|--------------------------------|
| Terraform        | Infrastructure as Code (IaC)   |
| AWS VPC          | Networking layer               |
| EC2              | Virtual machines (instances)  |
| ALB              | Load balancing HTTP traffic   |
| Auto Scaling     | Manage instance scaling       |
| IGW + Route Table| Public internet connectivity  |

---

## 🗂️ Project Structure

.
├── main.tf            # Main Terraform configuration including all resources
├── user_data.sh       # EC2 instance startup script (user data)
└── README.md          # This documentation file

---


## Architecture Diagram

         ┌──────────────┐
         │   Internet   │
         └─────┬────────┘
               │
         ┌─────▼──────┐
         │  ALB (80)  │
         └────┬───────┘
              │
        ┌─────▼──────┐
        │ Target Grp │  ◄── Health checks (HTTP 200 on "/")
        └────┬───────┘
             │
   ┌─────────▼─────────┐
   │ Auto Scaling Group│
   └─────────┬─────────┘
             │
     ┌───────▼────────┐
     │ Launch Template│
     └───────┬────────┘
             │
   ┌─────────▼────────┐
   │   Public Subnet  │ (ap-south-1a / ap-south-1b)
   └─────────┬────────┘
             │
       ┌─────▼──────┐
       │    VPC     │
       └─────┬──────┘
             │
       ┌─────▼──────┐
       │  IGW + RT  │ (Internet Gateway + Route Table)
       └────────────┘

## How to setup 

# Clone the repository
git clone https://github.com/your-username/aws-autoscaling-terraform.git
cd aws-autoscaling-terraform

# Initialize Terraform (download providers, etc)
terraform init

# Check what will be created or changed
terraform plan

# Deploy the infrastructure
terraform apply
