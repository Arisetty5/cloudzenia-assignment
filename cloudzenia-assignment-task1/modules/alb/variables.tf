
variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "name" {
  description = "The name of the ALB"
  type        = string
}

variable "security_groups" {
  description = "Security groups for the ALB"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets to attach the ALB to"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for Target Group"
  type        = string
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "certificate_arn" {
  description = "SSL Certificate ARN from ACM"
  type        = string
}

variable "tags" {
  description = "Tags to associate with resources"
  type        = map(string)
  default     = {}
}

