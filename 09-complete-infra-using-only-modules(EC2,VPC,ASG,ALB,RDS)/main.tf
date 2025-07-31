terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "VPC-module" {
  source         = "./modules/VPC"
  vpc_cidr_block = "10.0.0.0/16"
  subnets = [
    {
      availability_zone = "ap-south-1a"
      cidr_block        = "10.0.0.0/24"
      name              = "private-subnet-1"
    },
    {
      availability_zone = "ap-south-1b"
      cidr_block        = "10.0.3.0/24"
      name              = "private-subnet-2"
    },
    {
      availability_zone = "ap-south-1b"
      cidr_block        = "10.0.1.0/24"
      name              = "public-subnet-1"
      isPublic          = true
    },
    {
      availability_zone = "ap-south-1c"
      cidr_block        = "10.0.2.0/24"
      name              = "public-subnet-2"
      isPublic          = true
    },
  ]
}

module "RDS-module" {
  source                                  = "./modules/RDS"
  vpc_id                                  = module.VPC-module.vpc_id
  private-subnet_ids-for-rds-subnet-group = module.VPC-module.private-subnet-ids
}

module "ALB-module" {
  source            = "./modules/ALB"
  public-subnet-ids = module.VPC-module.public-subnet-ids
  vpc_id            = module.VPC-module.vpc_id
}

module "ASG-moduel" {
  source                      = "./modules/ASG"
  instance_type               = "t3.micro"
  image_id                    = "ami-0d0ad8bb301edb745"
  public_subnet_ids           = module.VPC-module.public-subnet-ids
  vpc_id                      = module.VPC-module.vpc_id
  target_group_arn            = module.ALB-module.target_group_arn
  associate_public_ip_address = true
}
