output "id" {
  description = "The ID of the network ACL."
  value       = aws_network_acl.main.id
}

output "arn" {
  description = "The ARN of the network ACL."
  value       = aws_network_acl.main.arn
}