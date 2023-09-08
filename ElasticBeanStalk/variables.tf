variable "elasticapp" {
  default = "flaskapp"
}
variable "beanstalkappenv" {
  default = "myenv"
}
variable "solution_stack_name" {
  type = string
}
variable "tier" {
  type = string
}

variable "vpc_id" {}
variable "public_subnets" {}
variable "elb_public_subnets" {}
variable "Instance_type" {}
variable "minsize" {
  type = number
}
variable "maxsize" {
  type = number
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}