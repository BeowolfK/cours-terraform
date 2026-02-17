# Outputs pour afficher les informations de connexion
output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "Adresse IP publique de l'instance"
  value       = aws_instance.main.public_ip
}

output "instance_private_ip" {
  description = "Adresse IP privée de l'instance"
  value       = aws_instance.main.private_ip
}

output "ssh_connection_command" {
  description = "Commande pour se connecter via SSH"
  value       = "ssh -i aws-ec2-key ec2-user@${aws_instance.main.public_ip}"
}

output "security_group_id" {
  description = "ID du security group"
  value       = aws_security_group.allow_ssh.id
}
