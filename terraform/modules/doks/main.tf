terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.34"
    }
  }
}

# DigitalOcean Kubernetes Cluster
resource "digitalocean_kubernetes_cluster" "kms_cluster" {
  name    = "${var.project_name}-cluster"
  region  = var.region
  version = var.kubernetes_version
  vpc_uuid = var.vpc_uuid

  # Node pool configuration
  node_pool {
    name       = "${var.project_name}-node-pool"
    size       = var.node_size
    node_count = var.node_count
    auto_scale = false
    min_nodes  = var.node_count
    max_nodes  = var.node_count

    tags = [
      "${var.project_name}-nodes",
      "ManagedBy-Terraform"
    ]
  }

  tags = [
    var.project_name,
    "ManagedBy-Terraform"
  ]
}
