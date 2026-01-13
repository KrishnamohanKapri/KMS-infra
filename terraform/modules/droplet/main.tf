terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.34"
    }
  }
}

# DigitalOcean Droplet (Bastion host)
resource "digitalocean_droplet" "bastion" {
  name     = "${var.project_name}-bastion"
  image    = "ubuntu-22-04-x64"  # Ubuntu 22.04
  region   = var.region
  size     = "s-1vcpu-1gb"  # $6/month - smallest option
  vpc_uuid = var.vpc_uuid
  ssh_keys = [var.ssh_key_fingerprint]

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y git curl
    # Install kubectl will be done via Ansible
  EOF

  tags = [
    "${var.project_name}-bastion",
    "ManagedBy-Terraform"
  ]
}
