variable "name" {}
variable "aws_ami" {}
# variable "myipaddr" {
#   description = "My Ip Address"
#   type = string
# }
variable "account" {}
variable "private_subnet_ids" {}
variable "vpc_id" {}

variable "instance_type" {
  description = "EC2 instance type."
  default     = "t3.medium"
}

variable "tags" {
  default = {}
}