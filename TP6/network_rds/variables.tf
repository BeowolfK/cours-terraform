# ID du security group du bastion (fourni par Student B)
# Laisser vide lors du premier deploiement, puis renseigner apres le deploiement du bastion
variable "bastion_sg_id" {
  description = "ID du security group du bastion (fourni par Student B)"
  type        = string
  default     = ""
}

# Mot de passe de la base de donnees
variable "db_password" {
  description = "Mot de passe pour l'utilisateur labadmin"
  type        = string
  sensitive   = true
  default     = "LabAdmin2024!"
}
