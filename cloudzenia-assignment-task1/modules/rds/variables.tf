variable "project_name" {}

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
