variable "vpc_cidr" {
    description = "CIDR block for VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
    description = "CIDR for public subnet 1"
    type = string
    default = "10.0.1.0/24"
}

variable "public_subnet2_cidr" {
    description = "CIDR for public subnet 2"
    type = string
    default = "10.0.2.0/24"
}

variable "private_subnet1_cidr" {
    description = "CIDR for private subnet 1"
    type = string
    default = "10.0.3.0/24"
}

variable "private_subnet2_cidr" {
    description = "CIDR for private subnet 2"
    type = string
    default = "10.0.4.0/24"
}

variable "aws_az_1" {
  description = "aws_region 2a"
  type = string
  default = "eu-west-2a"
}

variable "aws_az_2" {
  description = "aws_region 2b"
  type = string
  default = "eu-west-2b"
}

variable "internet_cidr" {
  description = "all IPV4 addresses"
  type = string
  default = "0.0.0.0/0"
}

variable "vpc_id" {
    description = "VPC ID"
    type = string
    default = output.vpc_id
}