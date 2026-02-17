# Terraform Docker Container Module

This Terraform module allows you to deploy multiple Docker containers with configurable parameters including image, memory, privileges, and port mappings.

## Features

- 🐳 Deploy multiple Docker containers from any image
- 🔧 Configurable memory limits
- 🔒 Optional privileged mode
- 🔢 Dynamic port mapping with automatic incrementation
- 📦 Reusable and modular design

## Requirements

- Terraform >= 1.0
- Docker installed and running
- Docker provider: kreuzwerker/docker ~> 3.0

## Module Variables

| Variable | Description | Type | Default | Required |
|----------|-------------|------|---------|----------|
| `image_name` | Docker image to use (e.g., nginx:latest, httpd:alpine) | string | "nginx:latest" | no |
| `container_memory` | Memory limit for containers in MB | number | 512 | no |
| `privileged` | Run containers in privileged mode | bool | false | no |
| `container_count` | Number of containers to spawn (1-10) | number | 1 | no |
| `starting_port` | Starting external port number | number | 3000 | no |
| `internal_port` | Internal container port to expose | number | 80 | no |
| `container_name_prefix` | Prefix for container names | string | "terraform-container" | no |

## Outputs

| Output | Description |
|--------|-------------|
| `container_ids` | IDs of the created containers |
| `container_names` | Names of the created containers |
| `container_ports` | Detailed port mapping for each container |
| `image_used` | Docker image used for the containers |

## Usage Examples

### Local Usage

Create a `main.tf` file in a new directory:

```hcl
module "docker_containers" {
  source = "./path/to/module"

  image_name            = "nginx:alpine"
  container_count       = 3
  container_memory      = 256
  privileged            = false
  starting_port         = 8080
  container_name_prefix = "my-nginx"
}

output "containers" {
  value = module.docker_containers.container_ports
}
```

### Using from GitHub

```hcl
module "docker_containers" {
  source = "github.com/your-username/terraform-docker-module"

  image_name            = "httpd:latest"
  container_count       = 5
  container_memory      = 512
  privileged            = false
  starting_port         = 3000
  internal_port         = 80
  container_name_prefix = "web-server"
}
```

### Using a Specific Branch or Tag

```hcl
module "docker_containers" {
  source = "github.com/your-username/terraform-docker-module?ref=v1.0.0"

  image_name       = "redis:alpine"
  container_count  = 2
  starting_port    = 6379
  internal_port    = 6379
}
```

### Using a Classmate's Module

```hcl
module "docker_containers" {
  source = "github.com/classmate-username/terraform-docker-module"

  image_name            = "postgres:14"
  container_count       = 2
  container_memory      = 1024
  starting_port         = 5432
  internal_port         = 5432
  container_name_prefix = "postgres-db"
}
```

## How It Works

The module creates:
1. A Docker image resource that pulls the specified image
2. Multiple Docker container resources based on `container_count`
3. Each container gets:
   - A unique name: `{container_name_prefix}-{number}`
   - An incremented external port: `starting_port`, `starting_port + 1`, `starting_port + 2`, etc.
   - The specified memory limit and privilege settings

### Example: 3 Containers Starting at Port 3000

```hcl
container_count = 3
starting_port   = 3000
```

Results in:
- Container 1: `terraform-container-1` → localhost:3000
- Container 2: `terraform-container-2` → localhost:3001
- Container 3: `terraform-container-3` → localhost:3002

## Deployment Steps

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Preview the changes:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

4. View outputs:
   ```bash
   terraform output
   ```

5. Destroy resources when done:
   ```bash
   terraform destroy
   ```

## Testing the Containers

After deployment, test your containers:

```bash
# Test first container
curl http://localhost:3000

# Test second container
curl http://localhost:3001

# Test third container
curl http://localhost:3002
```

## Publishing to GitHub

1. Initialize git repository:
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Terraform Docker module"
   ```

2. Create a repository on GitHub and push:
   ```bash
   git remote add origin https://github.com/your-username/terraform-docker-module.git
   git branch -M main
   git push -u origin main
   ```

3. (Optional) Create a release tag:
   ```bash
   git tag -a v1.0.0 -m "Version 1.0.0"
   git push origin v1.0.0
   ```

## License

This module is provided as-is for educational purposes.

## Author

Created for IMT IaC Lab 2
