variable "vpc_cidr_block" {
  type = string
}

variable "subnets" {
  type = list(object({
    availability_zone = string
    cidr_block = string 
    name = string 
    isPublic = optional(bool,false)
  }))
}