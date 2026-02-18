# ID de l'Auto Scaling Group
output "asg_id" {
  description = "ID de l'Auto Scaling Group"
  value       = aws_autoscaling_group.this.id
}

# Nom de l'Auto Scaling Group
output "asg_name" {
  description = "Nom de l'Auto Scaling Group"
  value       = aws_autoscaling_group.this.name
}

# ARN de l'Auto Scaling Group
output "asg_arn" {
  description = "ARN de l'Auto Scaling Group"
  value       = aws_autoscaling_group.this.arn
}

# ID du Launch Template utilisé
output "launch_template_id" {
  description = "ID du Launch Template"
  value       = aws_launch_template.this.id
}

# Dernière version du Launch Template
output "launch_template_version" {
  description = "Version du Launch Template"
  value       = aws_launch_template.this.latest_version
}
