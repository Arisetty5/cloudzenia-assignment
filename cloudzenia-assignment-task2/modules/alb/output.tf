output "alb_dns_name" {
  description = "The DNS name of the ALB"  
  value = aws_lb.app_alb.dns_name
}

output "alb_arn" {
  description = "ARN of the Load Balancer"
  value       = aws_lb.app_alb.arn
}

output "target_group_arn" {
  description = "ARN of the Target Group"  
  value = aws_lb_target_group.lb_tg.arn
}

