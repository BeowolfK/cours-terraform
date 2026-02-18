# Endpoint de l'instance RDS
output "rds_endpoint" {
  description = "Endpoint de connexion RDS"
  value       = aws_db_instance.lab6.endpoint
}

# Adresse de l'instance RDS (sans le port)
output "rds_address" {
  description = "Adresse de l'instance RDS"
  value       = aws_db_instance.lab6.address
}

# Port de l'instance RDS
output "rds_port" {
  description = "Port de l'instance RDS"
  value       = aws_db_instance.lab6.port
}

# ID du security group RDS (a partager avec Student B)
output "rds_sg_id" {
  description = "ID du security group RDS"
  value       = aws_security_group.rds.id
}

# Nom de la base de donnees
output "db_name" {
  description = "Nom de la base de donnees"
  value       = aws_db_instance.lab6.db_name
}

# ID du VPC
output "vpc_id" {
  description = "ID du VPC Lab5-6"
  value       = data.aws_vpc.lab56.id
}

# ID du subnet prive B (cree pour RDS)
output "private_subnet_b_id" {
  description = "ID du subnet prive B"
  value       = aws_subnet.private_b.id
}
