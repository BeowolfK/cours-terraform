# Nom de l'ASG Nginx
output "nginx_asg_name" {
  description = "Nom de l'ASG Nginx"
  value       = module.nginx_asg.asg_name
}

# ID de l'ASG Nginx
output "nginx_asg_id" {
  description = "ID de l'ASG Nginx"
  value       = module.nginx_asg.asg_id
}

# Nom de l'ASG Tomcat
output "tomcat_asg_name" {
  description = "Nom de l'ASG Tomcat"
  value       = module.tomcat_asg.asg_name
}

# ID de l'ASG Tomcat
output "tomcat_asg_id" {
  description = "ID de l'ASG Tomcat"
  value       = module.tomcat_asg.asg_id
}

# ID de l'AMI Bitnami Nginx utilisée
output "nginx_ami_id" {
  description = "ID de l'AMI Bitnami Nginx utilisée"
  value       = data.aws_ami.bitnami_nginx.id
}

# Nom de l'AMI Bitnami Nginx
output "nginx_ami_name" {
  description = "Nom de l'AMI Bitnami Nginx"
  value       = data.aws_ami.bitnami_nginx.name
}

# ID de l'AMI Bitnami Tomcat utilisée
output "tomcat_ami_id" {
  description = "ID de l'AMI Bitnami Tomcat utilisée"
  value       = data.aws_ami.bitnami_tomcat.id
}

# Nom de l'AMI Bitnami Tomcat
output "tomcat_ami_name" {
  description = "Nom de l'AMI Bitnami Tomcat"
  value       = data.aws_ami.bitnami_tomcat.name
}

# ID du subnet privé utilisé par les instances
output "private_subnet_id" {
  description = "ID du subnet privé utilisé"
  value       = data.aws_subnet.private.id
}

# ID du security group internal utilisé par les instances
output "internal_sg_id" {
  description = "ID du security group internal utilisé"
  value       = data.aws_security_group.internal.id
}

# ARN du target group nginx
output "nginx_tg_arn" {
  description = "ARN du target group nginx"
  value       = data.aws_lb_target_group.nginx.arn
}

# ARN du target group tomcat
output "tomcat_tg_arn" {
  description = "ARN du target group tomcat"
  value       = data.aws_lb_target_group.tomcat.arn
}
