# variables.tf

variable "project_name" {
  description = "Name prefix for all resources."
  type        = string
}

variable "region" {
  description = "AWS region to deploy resources."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for the subnets."
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID to be associated with ALB."
  type        = string
  default     = "" # Default to empty,since we are creating security groups within Terraform itself
}

variable "key_name" {}