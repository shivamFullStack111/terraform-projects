variable "vpc_cidr_block" {
    type = string
}

variable "vpc_name" {
    type = string
}

variable "subnets" {
  type = list(object({
    name = string 
    isPublic=optional(bool,false)
    cidr_block=string 
    availability_zone=string
  }))
}
