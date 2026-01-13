terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.34"
    }
  }
}

# DigitalOcean VPC (much simpler than OCI VCN)
resource "digitalocean_vpc" "kms_vpc" {
  name     = "${var.project_name}-vpc"
  region   = var.region
  ip_range = "10.0.0.0/16"  # Private IP range for VPC
}