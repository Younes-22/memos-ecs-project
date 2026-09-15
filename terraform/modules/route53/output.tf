output "lab_nameservers" {
  description = "Route 53 nameservers for lab.younesblog.org"
  value = aws_route53_zone.lab.name_servers
}

output "zone_id" {
  value = aws_route53_zone.lab.zone_id
}