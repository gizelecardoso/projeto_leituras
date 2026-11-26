output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.app.id
}

output "public_ip" {
  description = "EC2 public IPv4 address"
  value       = aws_instance.app.public_ip
}

output "public_dns" {
  description = "EC2 public DNS hostname"
  value       = aws_instance.app.public_dns
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.app.repository_url
}
