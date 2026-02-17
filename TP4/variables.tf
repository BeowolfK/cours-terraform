# Variables pour rendre le module configurable

variable "instance_name" {
  description = "Nom de l'instance EC2"
  type        = string
  default     = "terraform-ec2-instance"
}

variable "instance_type" {
  description = "Type d'instance EC2 (t3.micro, t3.small, etc.)"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = can(regex("^t[2-3]\\.(nano|micro|small|medium|large)", var.instance_type))
    error_message = "Instance type must be a valid t2 or t3 instance type."
  }
}

variable "subnet_id" {
  description = "ID du subnet où déployer l'instance"
  type        = string
  default     = "subnet-0d2b7f8e860ab5e38"
}

variable "ssh_key_name" {
  description = "Nom de la clé SSH dans AWS"
  type        = string
  default     = "terraform-ec2-key"
}

variable "ssh_public_key_path" {
  description = "Chemin vers la clé publique SSH"
  type        = string
  default     = "aws-ec2-key.pub"
}

variable "volume_size" {
  description = "Taille du disque en GB"
  type        = number
  default     = 30  # Minimum requis pour Amazon Linux 2023
}

variable "security_group_name" {
  description = "Nom du security group"
  type        = string
  default     = "terraform-allow-ssh"
}

variable "allow_ssh_from_cidr" {
  description = "CIDR autorisé pour SSH (0.0.0.0/0 = partout)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Variables pour l'Auto Scaling Group
variable "asg_min_size" {
  description = "Nombre minimum d'instances dans l'ASG"
  type        = number
  default     = 1

  validation {
    condition     = var.asg_min_size >= 0 && var.asg_min_size <= 10
    error_message = "ASG min size must be between 0 and 10."
  }
}

variable "asg_max_size" {
  description = "Nombre maximum d'instances dans l'ASG"
  type        = number
  default     = 2

  validation {
    condition     = var.asg_max_size >= 1 && var.asg_max_size <= 10
    error_message = "ASG max size must be between 1 and 10."
  }
}
