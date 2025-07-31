terraform {
  required_version = ">=1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=6.4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc-module" {
  source         = "./modules/VPC"
  vpc_name       = "my-VPC"
  vpc_cidr_block = "10.0.0.0/16"
  subnets = [
    {
      availability_zone = "ap-south-1a"
      cidr_block        = "10.0.0.0/24",
      isPublic          = true
      name              = "public-subnet-1"
    },
    {

      availability_zone = "ap-south-1b"
      cidr_block        = "10.0.1.0/24",
      isPublic          = true
      name              = "public-subnet-2"
    },
    {
      availability_zone = "ap-south-1c"
      cidr_block        = "10.0.2.0/24",
      name              = "private-subnet-1"
    }
  ]
}

module "ALB" {
  source             = "./modules/ALB"
  internal           = false
  load_balancer_type = "application"
  subnet_ids         = [for subnet in module.vpc-module.subnets : subnet.id]
  LB_name            = "my-LB"
  vpc_id             = module.vpc-module.vpc_id
}

module "ASG" {
  source                        = "./modules/ASG"
  # for ASG block 
  vpc_id = module.vpc-module.vpc_id
  ASG_desired_capacity          = 2
  ASG_force_delete              = true
  ASG_health_check_grace_period = 300
  ASG_health_check_type         = "ELB"
  ASG_max_size                  = 3
  ASG_min_size                  = 1
  ASG_vpc_zone_identifier       = [for sub in module.vpc-module.subnets : sub.id]
  ASG_target_group_arn = [module.ALB.target_group_arn]

  # for launch template block 
  LT_associate_public_ip_address = true 
  LT_image_id = "ami-0d0ad8bb301edb745"
  LT_instance_type = "t2.nano" 
  LT_vpc_security_group_ids = [ module.ALB.security_group_id ]
}

