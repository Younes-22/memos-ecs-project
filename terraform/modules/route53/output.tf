output "zone_id" {
  description = "Route 53 hosted zone ID"
  value       = data.aws_route53_zone.lab.zone_id
}

output "lab_nameservers" {
  description = "Route 53 nameservers for lab.younesblog.org"
  value       = data.aws_route53_zone.lab.name_servers
}