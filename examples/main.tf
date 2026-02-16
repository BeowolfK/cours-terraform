# Example 1: Basic usage with default values
module "basic_containers" {
  source = "../"  # For local testing, use: source = "github.com/your-username/terraform-docker-module"
}

# Example 2: Multiple nginx containers with custom configuration
module "nginx_cluster" {
  source = "../"

  image_name            = "nginx:alpine"
  container_count       = 3
  container_memory      = 256
  privileged            = false
  starting_port         = 8080
  internal_port         = 80
  container_name_prefix = "nginx-web"
}

# Example 3: Redis containers for testing
module "redis_instances" {
  source = "../"

  image_name            = "redis:alpine"
  container_count       = 2
  container_memory      = 512
  starting_port         = 6379
  internal_port         = 6379
  container_name_prefix = "redis-cache"
}

# Example 4: Using a classmate's module from GitHub
# Uncomment and modify with actual GitHub username
# module "classmate_containers" {
#   source = "github.com/classmate-username/terraform-docker-module"
#
#   image_name       = "httpd:latest"
#   container_count  = 4
#   starting_port    = 3000
#   container_memory = 512
# }

# Outputs to display container information
output "nginx_containers" {
  description = "Nginx container details"
  value       = module.nginx_cluster.container_ports
}

output "redis_containers" {
  description = "Redis container details"
  value       = module.redis_instances.container_ports
}
