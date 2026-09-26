variable "vpc_id" {
  description = "vpc ID for ecs tasks"
  type = string
}

variable "alb_security_group_id" {
  description = "alb security group"
  type = string
}

variable "private_subnet_1_id" {
  type = string
}

variable "private_subnet_2_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "execution_role_arn" {
  type = string
  description = "IAM role used by ECS to execute the task"
}

variable "container_image" {
  description = "Docker image to run"   
  type = string
  default     = "872450837551.dkr.ecr.eu-west-2.amazonaws.com/my-memos-app:latest"
}