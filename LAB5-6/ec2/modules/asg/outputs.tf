# Outputs du module ASG

output "asg_id" {
  description = "ID de l'Auto Scaling Group"
  value       = aws_autoscaling_group.this.id
}

output "asg_name" {
  description = "Nom de l'Auto Scaling Group"
  value       = aws_autoscaling_group.this.name
}

output "asg_arn" {
  description = "ARN de l'Auto Scaling Group"
  value       = aws_autoscaling_group.this.arn
}

output "launch_template_id" {
  description = "ID du Launch Template"
  value       = aws_launch_template.this.id
}

output "launch_template_version" {
  description = "Version du Launch Template"
  value       = aws_launch_template.this.latest_version
}
