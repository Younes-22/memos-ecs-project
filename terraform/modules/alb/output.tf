output "alb_arn" {
  value = aws_lb.this.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Canonical hosted zone ID of the ALB"
  value = aws_lb.this.zone_id
}