# Variables pour le module ASG

variable "name" {
  description = "Nom de l'ASG"
  type        = string
}

variable "ami_id" {
  description = "ID de l'AMI à utiliser"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Nombre minimum d'instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Nombre maximum d'instances"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Nombre désiré d'instances"
  type        = number
  default     = 2
}

variable "subnet_ids" {
  description = "Liste des subnet IDs où déployer les instances"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Liste des security group IDs"
  type        = list(string)
}

variable "target_group_arns" {
  description = "Liste des target group ARNs à attacher"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "Type de health check (EC2 ou ELB)"
  type        = string
  default     = "ELB"
}

variable "health_check_grace_period" {
  description = "Période de grâce pour le health check (secondes)"
  type        = number
  default     = 300
}
