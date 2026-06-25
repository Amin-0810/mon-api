terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "api" {
  name         = var.image_name
  keep_locally = true
}



resource "docker_container" "staging" {
  name  = "api-staging"
  image = docker_image.api.image_id

  ports {
    internal = 8000
    external = var.staging_port
  }

  networks_advanced {
    name = "mon-api_cicd-network"
  }

  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost:8000/health"]
    interval = "10s"
    timeout  = "5s"
    retries  = 3
  }
}