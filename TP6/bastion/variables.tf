# Adresse IP autorisee pour SSH (votre IP publique)
variable "my_ip" {
  description = "Votre adresse IP publique pour l'acces SSH (format: x.x.x.x/32)"
  type        = string
  default     = "0.0.0.0/0" # A remplacer par votre IP publique
}

# Cle SSH pour le bastion
variable "key_name" {
  description = "Nom de la cle SSH existante dans AWS"
  type        = string
  default     = "student_7_9_key"
}
