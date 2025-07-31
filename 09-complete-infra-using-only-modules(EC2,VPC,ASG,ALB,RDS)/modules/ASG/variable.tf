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