data "aws_route53_zone" "lab" {
  name = "lab.younesblog.org"
  private_zone = false
}