terraform {
  required_version = ">= 1.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "terraform_demo" {
  name  = "terraform-nginx-demo"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8082
  }
}

output "application_url" {
  value = "http://localhost:8082"
}
