# IP publique du bastion
output "bastion_public_ip" {
  description = "Adresse IP publique du bastion"
  value       = aws_instance.bastion.public_ip
}

# Commande SSH pour se connecter au bastion
output "ssh_command" {
  description = "Commande SSH pour se connecter au bastion"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.bastion.public_ip}"
}

# ID du security group du bastion (a partager avec Student A pour l'etape 3)
output "bastion_sg_id" {
  description = "ID du security group du bastion (a fournir a Student A)"
  value       = aws_security_group.bastion.id
}

# ID de l'instance bastion
output "bastion_instance_id" {
  description = "ID de l'instance EC2 bastion"
  value       = aws_instance.bastion.id
}

# Endpoint RDS (recupere depuis SSM)
output "rds_endpoint" {
  description = "Endpoint RDS (depuis data source)"
  value       = data.aws_ssm_parameter.db_endpoint.value
  sensitive   = true
}

# Nom de la base de donnees
output "db_name" {
  description = "Nom de la base de donnees"
  value       = data.aws_ssm_parameter.db_name.value
  sensitive   = true
}

# ID du security group RDS
output "rds_sg_id" {
  description = "ID du security group RDS"
  value       = data.aws_security_group.rds.id
}
