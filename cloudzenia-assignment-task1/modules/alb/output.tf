# ./modules/alb/outputs.tf

output "wordpress_tg_arn" {
  value       = aws_alb_target_group.wordpress.arn
  description = "ARN of the WordPress target group"
}

output "microservice_tg_arn" {
  value       = aws_alb_target_group.microservice.arn
  description = "ARN of the microservice target group"
}

output "app_alb_dns_name" {
  value       = aws_alb.app_alb.dns_name
  description = "DNS name of the Application Load Balancer"
}

