
variable "cluster_name" {}
variable "service_name" {}
variable "project_name" {}

variable "db_name" {}
variable "wordpress_image" {}

variable "private_subnets" {
  type = list(string)
}

variable "service_security_groups" {
  type = list(string)
}

variable "tags" {
  default = {}
}

variable "microservice_image" {
  description = "Docker image URL for Node.js microservice"
  type        = string
}

variable "microservice_target_group_arn" {
  description = "Target group ARN for microservice"
  type        = string
}

variable "secretsmanager_secret_arn" {
  type        = string
  description = "ARN of the Secrets Manager secret containing database credentials"
}

variable "alb_wordpress_target_group_arn" {
  type        = string
  description = "ARN of the WordPress ALB target group"
}

variable "alb_microservice_target_group_arn" {
  type        = string
  description = "ARN of the microservice ALB target group"
}

variable "rds_endpoint" {
  type        = string
  description = "The endpoint of the RDS database"
}

