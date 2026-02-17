# Outputs pour l'Auto Scaling Group

output "asg_name" {
  description = "Nom de l'Auto Scaling Group"
  value       = aws_autoscaling_group.app.name
}

output "asg_min_size" {
  description = "Taille minimum de l'ASG"
  value       = aws_autoscaling_group.app.min_size
}

output "asg_max_size" {
  description = "Taille maximum de l'ASG"
  value       = aws_autoscaling_group.app.max_size
}

output "asg_desired_capacity" {
  description = "Capacité désirée de l'ASG"
  value       = aws_autoscaling_group.app.desired_capacity
}

output "launch_template_id" {
  description = "ID du Launch Template"
  value       = aws_launch_template.app.id
}

output "launch_template_latest_version" {
  description = "Dernière version du Launch Template"
  value       = aws_launch_template.app.latest_version
}

output "ami_id" {
  description = "ID de l'AMI utilisée (récupérée via datasource)"
  value       = data.aws_ami.amazon_linux.id
}

output "ami_name" {
  description = "Nom de l'AMI utilisée"
  value       = data.aws_ami.amazon_linux.name
}

output "subnet_id" {
  description = "ID du subnet utilisé"
  value       = data.aws_subnet.selected.id
}

output "vpc_id" {
  description = "ID du VPC"
  value       = data.aws_vpc.selected.id
}

output "security_group_id" {
  description = "ID du security group"
  value       = aws_security_group.allow_ssh.id
}

output "workspace" {
  description = "Workspace Terraform actif"
  value       = terraform.workspace
}
