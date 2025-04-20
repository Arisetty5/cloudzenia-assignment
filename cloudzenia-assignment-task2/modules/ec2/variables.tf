variable "ami_id" {}
variable "instance_type" {}
variable "private_subnet_id" {}
variable "key_name" {}
variable "project_name" {}

variable "security_group_ids" {
  type = list(string)
}
variable "target_group_arn" {
  description = "The ARN of the ALB Target Group to attach EC2 Instances"
  type        = string
}

