output "github_ecr_role_arn" {
  description = "GitHub Actions role for ECR pushes"
  value       = aws_iam_role.github_ecr.arn
}

output "github_terraform_role_arn" {
  description = "GitHub Actions role for Terraform deployments"
  value       = aws_iam_role.github_terraform.arn
}