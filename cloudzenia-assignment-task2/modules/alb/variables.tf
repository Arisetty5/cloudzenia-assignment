variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID to attach to the ALB"
  type        = string
}

variable "subnet_ids" {
  description = "List of Public Subnet IDs for ALB"
  type        = list(string)
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "Port for target group traffic (e.g., 80)"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID where ALB and Target Group exist"
  type        = string
}