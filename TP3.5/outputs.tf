# Outputs pour afficher les informations de l'instance

output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "Adresse IP publique de l'instance"
  value       = aws_instance.main.public_ip
}

output "instance_public_dns" {
  description = "DNS public de l'instance"
  value       = aws_instance.main.public_dns
}

output "instance_private_ip" {
  description = "Adresse IP privée de l'instance"
  value       = aws_instance.main.private_ip
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

output "ssh_connection_command" {
  description = "Commande pour se connecter via SSH"
  value       = "ssh -i ${var.ssh_public_key_path} ec2-user@${aws_instance.main.public_ip}"
}
