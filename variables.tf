# Defining the variables 
variable "aws_owner_id" {
  description = "the account has the owner id of the AMI for Amazon linux"
  type        = string
}

variable "aws_ami_name" {
  description = "name of the ami wanted for the project"
  type        = string
}

variable "vpc_name" {
  description = "name of the vpc wanted for the project"
  type        = string
}

variable "private_subnet_name" {
  description = "name of the private subnet"
  type        = string
}

variable "public_subnet_name" {
  description = "name of the public subnet"
  type        = string
}


variable "my_keypair" {
  default = "aws_keypair"
}

variable "ec2_type" {
  description = "Type of my ec2 instance"
  type        = string
  default     = "t2.small"
}

variable "number_of_instances" {
  description = "Amount of instances for my private subnets"
}