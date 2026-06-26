terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Crée le réseau directement (plus besoin de docker compose)
resource "docker_network" "cicd" {
  name = "cicd-network"
}

resource "docker_image" "api" {
  name         = var.image_name
  keep_locally = true
}

resource "docker_container" "staging" {
  name  = "api-staging"
  image = docker_image.api.image_id

  ports {
    internal = 8000
    external = 8001
  }

  networks_advanced {
    name = docker_network.cicd.name
  }

  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost:8000/health"]
    interval = "10s"
    timeout  = "5s"
    retries  = 3
  }
}