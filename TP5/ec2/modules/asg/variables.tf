# Nom de l'ASG et du launch template
variable "name" {
  description = "Nom de l'ASG"
  type        = string
}

# ID de l'AMI à utiliser pour les instances
variable "ami_id" {
  description = "ID de l'AMI à utiliser"
  type        = string
}

# Type d'instance EC2 (ex: t3.micro)
variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3.micro"
}

# Nombre minimum d'instances maintenues par l'ASG
variable "min_size" {
  description = "Nombre minimum d'instances"
  type        = number
  default     = 2
}

# Nombre maximum d'instances autorisées par l'ASG
variable "max_size" {
  description = "Nombre maximum d'instances"
  type        = number
  default     = 4
}

# Nombre d'instances souhaitées au démarrage
variable "desired_capacity" {
  description = "Nombre désiré d'instances"
  type        = number
  default     = 2
}

# Subnets où déployer les instances
variable "subnet_ids" {
  description = "Liste des subnet IDs où déployer les instances"
  type        = list(string)
}

# Security groups attachés aux instances
variable "security_group_ids" {
  description = "Liste des security group IDs"
  type        = list(string)
}

# Target groups pour l'enregistrement automatique des instances
variable "target_group_arns" {
  description = "Liste des target group ARNs à attacher"
  type        = list(string)
  default     = []
}

# Type de health check : EC2 (basique) ou ELB (via le load balancer)
variable "health_check_type" {
  description = "Type de health check (EC2 ou ELB)"
  type        = string
  default     = "ELB"
}

# Temps d'attente avant de lancer les health checks (laisser le temps au démarrage)
variable "health_check_grace_period" {
  description = "Période de grâce pour le health check (secondes)"
  type        = number
  default     = 300
}

# Script bash exécuté au premier démarrage de chaque instance
variable "user_data" {
  description = "Script de démarrage pour les instances"
  type        = string
  default     = ""
}
