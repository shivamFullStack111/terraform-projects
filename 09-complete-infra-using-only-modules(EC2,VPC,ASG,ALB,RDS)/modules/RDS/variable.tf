variable "vpc_id" {
    type = string
}

variable "private-subnet_ids-for-rds-subnet-group" {
  type = list(string)
}