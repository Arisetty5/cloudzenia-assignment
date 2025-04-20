output "wordpress_alb_url" {
  value = "http://${module.alb.app_alb_dns_name}"
  description = "WordPress ALB HTTP URL"
}

output "microservice_alb_url" {
  value = "http://${module.alb.app_alb_dns_name}" # Microservice will also be on the same ALB initially
  description = "Microservice ALB HTTP URL"
}

output "alb_dns_name" {
  value = module.alb.app_alb_dns_name
  description = "ALB DNS Name"
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}
