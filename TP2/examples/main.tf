module "nginx_cluster" {
  source = "github.com/BeowolfK/cours-terraform"

  image_name            = "nginx:alpine"
  container_count       = 3
  container_memory      = 256
  privileged            = false
  starting_port         = 8080
  internal_port         = 80
  container_name_prefix = "nginx-web"
}

