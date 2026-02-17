# Outputs requis pour Student X

# Subnet IDs
output "private_subnet_id" {
  description = "ID du subnet privé"
  value       = aws_subnet.private.id
}

output "public_subnet_a_id" {
  description = "ID du subnet public A"
  value       = aws_subnet.public_a.id
}

output "public_subnet_b_id" {
  description = "ID du subnet public B"
  value       = aws_subnet.public_b.id
}

# Security Group IDs
output "public_sg_id" {
  description = "ID du security group public"
  value       = aws_security_group.public.id
}

output "internal_sg_id" {
  description = "ID du security group internal"
  value       = aws_security_group.internal.id
}

# Target Group ARNs
output "nginx_tg_arn" {
  description = "ARN du target group nginx"
  value       = aws_lb_target_group.nginx.arn
}

output "tomcat_tg_arn" {
  description = "ARN du target group tomcat"
  value       = aws_lb_target_group.tomcat.arn
}

# ALB DNS Name
output "alb_dns_name" {
  description = "DNS name du load balancer"
  value       = aws_lb.main.dns_name
}

output "alb_arn" {
  description = "ARN du load balancer"
  value       = aws_lb.main.arn
}

# VPC ID pour référence
output "vpc_id" {
  description = "ID du VPC Lab5-6"
  value       = data.aws_vpc.lab56.id
}
