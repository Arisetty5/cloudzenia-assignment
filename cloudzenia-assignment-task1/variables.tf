

variable "cluster_name" {}
variable "service_name" {}
variable "region" {}
variable "project_name" {}
variable "vpc_cidr" {}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "microservice_image" {
  description = "Docker image URL for Node.js microservice"
  type        = string
}

# Variables for RDS Module

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_name" {}
variable "db_username" {}
variable "db_password" {}

variable "db_security_group_ids" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "name" {
  
}

variable "wordpress_image" {}
variable "alb_name" {}
variable "certificate_arn" {
  
}

variable "secretsmanager_secret_arn" {
  type        = string
  description = "ARN of the Secrets Manager secret containing database credentials"
}

