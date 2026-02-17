# ID du subnet privé pour les instances EC2
output "private_subnet_id" {
  description = "ID du subnet privé"
  value       = aws_subnet.private.id
}

# ID du subnet public A (AZ 0) pour l'ALB
output "public_subnet_a_id" {
  description = "ID du subnet public A"
  value       = aws_subnet.public_a.id
}

# ID du subnet public B (AZ 1) pour l'ALB
output "public_subnet_b_id" {
  description = "ID du subnet public B"
  value       = aws_subnet.public_b.id
}

# ID du security group public (ALB)
output "public_sg_id" {
  description = "ID du security group public"
  value       = aws_security_group.public.id
}

# ID du security group internal (instances EC2)
output "internal_sg_id" {
  description = "ID du security group internal"
  value       = aws_security_group.internal.id
}

# ARN du target group nginx pour l'enregistrement des instances
output "nginx_tg_arn" {
  description = "ARN du target group nginx"
  value       = aws_lb_target_group.nginx.arn
}

# ARN du target group tomcat pour l'enregistrement des instances
output "tomcat_tg_arn" {
  description = "ARN du target group tomcat"
  value       = aws_lb_target_group.tomcat.arn
}

# DNS public de l'ALB pour accéder à l'application
output "alb_dns_name" {
  description = "DNS name du load balancer"
  value       = aws_lb.main.dns_name
}

# ARN de l'ALB
output "alb_arn" {
  description = "ARN du load balancer"
  value       = aws_lb.main.arn
}

# ID du VPC utilisé
output "vpc_id" {
  description = "ID du VPC Lab5-6"
  value       = data.aws_vpc.lab56.id
}
