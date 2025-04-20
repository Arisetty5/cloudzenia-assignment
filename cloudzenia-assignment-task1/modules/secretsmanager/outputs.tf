# ./modules/secretsmanager/outputs.tf

output "secret_arn" {
  value       = aws_secretsmanager_secret.cred_store.arn
  description = "ARN of the Secrets Manager secret"
}

output "secret_value_json" {
  value       = jsondecode(aws_secretsmanager_secret_version.secret_version.secret_string)
  description = "The secret value as a JSON object"
}