# Configure DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create SSH Key resource (if not exists, will be created)
resource "digitalocean_ssh_key" "kms_ssh_key" {
  name       = "${var.project_name}-ssh-key"
  public_key = var.ssh_public_key
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  region       = var.region
}

# DOKS Cluster Module
module "doks" {
  source = "./modules/doks"

  project_name       = var.project_name
  region             = var.region
  vpc_uuid           = module.vpc.vpc_uuid
  kubernetes_version = var.kubernetes_version
  node_size          = var.node_size
  node_count         = var.node_count

  depends_on = [module.vpc]
}

# Bastion Droplet Module (optional)
module "bastion" {
  count  = var.enable_bastion ? 1 : 0
  source = "./modules/droplet"

  project_name        = var.project_name
  region              = var.region
  vpc_uuid            = module.vpc.vpc_uuid
  ssh_key_fingerprint = digitalocean_ssh_key.kms_ssh_key.fingerprint

  depends_on = [module.vpc, digitalocean_ssh_key.kms_ssh_key]
}

# Ansible provisioner - runs after cluster is created
resource "null_resource" "configure_cluster" {
  count = var.enable_ansible_provisioning ? 1 : 0

  depends_on = [
    module.doks
  ]

  triggers = {
    cluster_id   = module.doks.cluster_id
    cluster_name = module.doks.cluster_name
  }

  provisioner "local-exec" {
    command = <<-EOT
      cd ${path.module}/../ansible && \
      ansible-playbook \
        -i inventory.yml \
        configure-doks.yml \
        -e cluster_name=${module.doks.cluster_name} \
        -e github_username=${var.github_username} \
        -e gitops_repo_path="${var.gitops_repo_path}" \
        -e gitops_repo_branch=${var.gitops_repo_branch}
    EOT

    environment = {
      GITHUB_PAT = var.github_pat != "" ? var.github_pat : ""
    }
  }
}