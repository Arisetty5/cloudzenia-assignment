output "rds_endpoint" {
  value       = aws_db_instance.db-instance.endpoint
  description = "The endpoint of the RDS instance"
}

output "rds_db_name" {
  value = aws_db_instance.db-instance.db_name
}



output "rds_username" {
  value = aws_db_instance.db-instance.username
}


