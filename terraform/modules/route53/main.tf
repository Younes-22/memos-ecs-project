# Create a hosted zone for the lab subdomain
resource "aws_route53_zone" "lab" {
  name = "lab.younesblog.org"
}

# Point lab.younesblog.org to the Application Load Balancer
resource "aws_route53_record" "lab" {
  zone_id = aws_route53_zone.lab.zone_id
  name    = "lab.younesblog.org"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
