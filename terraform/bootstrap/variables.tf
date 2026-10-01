variable "github_owner" {
  type    = string
  default = "Younes-22"
}

variable "github_repo" {
  type    = string
  default = "memos-ecs-project"
}

variable "project_name" {
  type    = string
  default = "memos"
}

variable "ecr_repository_name" {
  description = "ECR repository used by the application"
  type        = string
  default     = "my-memos-app"
}

variable "terraform_state_bucket" {
  description = "S3 bucket containing the Terraform state"
  type        = string
  default     = "memos-terraform-state-872450837551-872450837551-eu-west-2-an"
}

variable "terraform_state_key" {
  description = "S3 key for the application Terraform state"
  type        = string
  default     = "memos/terraform.tfstate"
}