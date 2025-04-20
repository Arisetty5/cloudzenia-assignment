output "instance1_public_ip" {
  value = module.ec2_instances.eip1_public_ip
}

output "instance2_public_ip" {
  value = module.ec2_instances.eip2_public_ip
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

