# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_uuid" {
  description = "UUID of the VPC"
  value       = module.vpc.vpc_uuid
}

# DOKS Outputs
output "cluster_id" {
  description = "ID of the Kubernetes cluster"
  value       = module.doks.cluster_id
}

output "cluster_name" {
  description = "Name of the Kubernetes cluster"
  value       = module.doks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint of the Kubernetes cluster"
  value       = module.doks.cluster_endpoint
}

output "kubernetes_version" {
  description = "Kubernetes version"
  value       = module.doks.kubernetes_version
}

# Bastion Outputs
output "bastion_public_ip" {
  description = "Public IP of the Bastion Droplet"
  value       = var.enable_bastion ? module.bastion[0].droplet_public_ip : null
}

output "bastion_private_ip" {
  description = "Private IP of the Bastion Droplet"
  value       = var.enable_bastion ? module.bastion[0].droplet_private_ip : null
}