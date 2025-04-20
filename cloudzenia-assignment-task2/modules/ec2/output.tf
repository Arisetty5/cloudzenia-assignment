
output "instance1_public_ip" {
  value = aws_eip.eip1.public_ip
}

output "instance2_public_ip" {
  value = aws_eip.eip2.public_ip
}

output "eip1_public_ip" {
  value = aws_eip.eip1.public_ip
}

output "eip2_public_ip" {
  value = aws_eip.eip2.public_ip
}
