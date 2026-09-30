# output "lab_nameservers" {
#   description = "Route 53 nameservers for lab.younesblog.org"
#   value       = module.route53.lab_nameservers
# }

output "github_actions_role_arn" {
  description = "ARN of the GitHub Actions IAM role"
  value       = module.iam.github_actions_role_arn
}