# ./modules/ecs/outputs.tf

output "cluster_id" {
  value       = aws_ecs_cluster.wordpress-node-cluster.id
  description = "ID of the ECS cluster"
}

output "wordpress_task_definition_arn" {
  value       = aws_ecs_task_definition.wordpress.arn
  description = "ARN of the WordPress task definition"
}

output "microservice_task_definition_arn" {
  value       = aws_ecs_task_definition.microservice.arn
  description = "ARN of the microservice task definition"
}

output "wordpress_service_arn" {
  value       = aws_ecs_service.wordpress_service
  description = "ARN of the WordPress ECS service"
}

output "microservice_service_arn" {
  value       = aws_ecs_service.microservice_service # Correct attribute name
  description = "ARN of the microservice ECS service"
}

output "wordpress_service_name" {
  value       = aws_ecs_service.wordpress_service.name
  description = "Name of the WordPress ECS service"
}

output "microservice_service_name" {
  value       = aws_ecs_service.microservice_service.name
  description = "Name of the microservice ECS service"
}