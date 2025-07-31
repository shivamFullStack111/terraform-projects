# for ASG block -----------------------------------------------
variable "vpc_id" {
  type = string
}
variable "ASG_max_size" {
  type = number
}
variable "ASG_min_size" {
  type = number
}
variable "ASG_desired_capacity" {
  type = number
}
variable "ASG_health_check_grace_period" {
  type = number
}
variable "ASG_health_check_type" {
  type = string
}
variable "ASG_force_delete" {
  type = bool 
  default = true
}
variable "ASG_vpc_zone_identifier" {
  type = list(string)
}

variable "ASG_target_group_arn" {
  type = list(string)
}

# for launch template ---------------------------------------------
variable "LT_image_id" {
  type = string
}

variable "LT_instance_type" {
  type = string
}

variable "LT_vpc_security_group_ids" {
  type = list(string)
}

variable "LT_associate_public_ip_address" {
  type = bool
  default = false
}

