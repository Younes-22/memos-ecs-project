output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_1_id" {
    value = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.private_2
}

output "private_subnet_1_id" {
  value = aws_subnet.private_1
}

output "private_subnet_2_id" {
  value = aws_subnet.private_2
}