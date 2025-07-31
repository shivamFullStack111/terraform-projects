variable "LB_name" {
  type = string
}

variable "internal" {
  type = bool
}

variable "load_balancer_type" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

