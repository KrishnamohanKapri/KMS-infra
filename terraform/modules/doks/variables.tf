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

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

variable "node_size" {
  description = "Droplet size for nodes"
  type        = string
}

variable "node_count" {
  description = "Number of nodes"
  type        = number
}
