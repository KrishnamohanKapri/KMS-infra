variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
}

variable "vpc_uuid" {
  description = "UUID of the VPC"
  type        = string
}

variable "ssh_key_fingerprint" {
  description = "Fingerprint of the SSH key (from digitalocean_ssh_key)"
  type        = string
}
