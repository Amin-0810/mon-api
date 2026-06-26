variable "image_name" {
  description = "Image Docker à déployer"
  type        = string
  default     = "ghcr.io/amin-0810/mon-api:latest"
}

variable "staging_port" {
  description = "Port du staging"
  type        = number
  default     = 8001
}