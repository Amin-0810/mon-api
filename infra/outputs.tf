output "staging_url" {
  description = "URL du serveur staging"

  value = "http://localhost:${var.staging_port}"
}

output "container_name" {
  value = docker_container.staging.name
}