terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source = "./modules/alb"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
}

module "ecs" {
  source                = "./modules/ecs"
  vpc_id                = module.vpc.vpc_id
  alb_security_group_id = module.alb.alb_security_group_id
  private_subnet_1_id   = module.vpc.private_subnet_1_id
  private_subnet_2_id   = module.vpc.private_subnet_2_id
  target_group_arn      = module.alb.target_group_arn

  execution_role_arn = module.iam.ecs_task_execution_role_arn

}

module "iam" {
  source = "./modules/iam"
}