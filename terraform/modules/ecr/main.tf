resource "aws_ecr_repository" "memos" {
  name = "my-memos-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "my-memos-app"
  }
}