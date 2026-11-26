variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Project name used to identify AWS resources"
  type        = string
  default     = "leitura"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}
