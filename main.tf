# Configuration Terraform : déclaration du provider Docker et sa version
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Configuration du provider Docker : connexion au daemon Docker local
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Téléchargement de l'image Docker configurée
resource "docker_image" "app" {
  name         = var.image_name
  keep_locally = false
}

# Création et démarrage des containers avec configuration variable
resource "docker_container" "app" {
  count = var.container_count

  image      = docker_image.app.image_id
  name       = "${var.container_name_prefix}-${count.index + 1}"
  privileged = var.privileged

  # Configuration de la mémoire
  memory = var.container_memory

  # Configuration du mapping de port avec incrémentation
  ports {
    internal = var.internal_port
    external = var.starting_port + count.index
  }
}
