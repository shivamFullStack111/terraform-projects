terraform {
  required_providers {
  name = {
    source = "hashicorp/aws"
    version = "6.4.0"
  }
  }
}


provider "aws" {
  region = "ap-south-1"
}

