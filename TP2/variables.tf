variable "image_name" {
  description = "Docker image to use (e.g., nginx:latest, httpd:alpine)"
  type        = string
  default     = "nginx:latest"
}

variable "container_memory" {
  description = "Memory limit for containers in MB"
  type        = number
  default     = 512
}

variable "privileged" {
  description = "Run containers in privileged mode"
  type        = bool
  default     = false
}

variable "container_count" {
  description = "Number of containers to spawn"
  type        = number
  default     = 5

  validation {
    condition     = var.container_count > 0 && var.container_count <= 10
    error_message = "Container count must be between 1 and 10."
  }
}

variable "starting_port" {
  description = "Starting external port number (each container will increment this)"
  type        = number
  default     = 3000

  validation {
    condition     = var.starting_port >= 1024 && var.starting_port <= 65525
    error_message = "Starting port must be between 1024 and 65525 to allow for container increments."
  }
}

variable "internal_port" {
  description = "Internal container port to expose"
  type        = number
  default     = 80
}

variable "container_name_prefix" {
  description = "Prefix for container names"
  type        = string
  default     = "terraform-container"
}
