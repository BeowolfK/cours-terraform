# Outputs pour Student Y (9)

# Nginx ASG
output "nginx_asg_name" {
  description = "Nom de l'ASG Nginx"
  value       = module.nginx_asg.asg_name
}

output "nginx_asg_id" {
  description = "ID de l'ASG Nginx"
  value       = module.nginx_asg.asg_id
}

# Tomcat ASG
output "tomcat_asg_name" {
  description = "Nom de l'ASG Tomcat"
  value       = module.tomcat_asg.asg_name
}

output "tomcat_asg_id" {
  description = "ID de l'ASG Tomcat"
  value       = module.tomcat_asg.asg_id
}

# AMI utilisées
output "nginx_ami_id" {
  description = "ID de l'AMI Bitnami Nginx utilisée"
  value       = data.aws_ami.bitnami_nginx.id
}

output "nginx_ami_name" {
  description = "Nom de l'AMI Bitnami Nginx"
  value       = data.aws_ami.bitnami_nginx.name
}

output "tomcat_ami_id" {
  description = "ID de l'AMI Bitnami Tomcat utilisée"
  value       = data.aws_ami.bitnami_tomcat.id
}

output "tomcat_ami_name" {
  description = "Nom de l'AMI Bitnami Tomcat"
  value       = data.aws_ami.bitnami_tomcat.name
}

# Ressources utilisées (de Student X)
output "private_subnet_id" {
  description = "ID du subnet privé utilisé"
  value       = data.aws_subnet.private.id
}

output "internal_sg_id" {
  description = "ID du security group internal utilisé"
  value       = data.aws_security_group.internal.id
}

output "nginx_tg_arn" {
  description = "ARN du target group nginx"
  value       = data.aws_lb_target_group.nginx.arn
}

output "tomcat_tg_arn" {
  description = "ARN du target group tomcat"
  value       = data.aws_lb_target_group.tomcat.arn
}
