terraform {
  backend "s3" {
    bucket       = "memos-terraform-state-872450837551-872450837551-eu-west-2-an"  #bucket i created on the console
    key          = "memos/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
}