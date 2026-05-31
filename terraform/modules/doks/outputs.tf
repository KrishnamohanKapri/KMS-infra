output "cluster_id" {
  description = "ID of the Kubernetes cluster"
  value       = digitalocean_kubernetes_cluster.kms_cluster.id
}

output "cluster_name" {
  description = "Name of the Kubernetes cluster"
  value       = digitalocean_kubernetes_cluster.kms_cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint of the Kubernetes cluster"
  value       = digitalocean_kubernetes_cluster.kms_cluster.endpoint
}

output "kube_config" {
  description = "Kubernetes config (sensitive)"
  value       = digitalocean_kubernetes_cluster.kms_cluster.kube_config
  sensitive   = true
}

output "kubernetes_version" {
  description = "Kubernetes version"
  value       = digitalocean_kubernetes_cluster.kms_cluster.version
}

output "cluster_urn" {
  description = "URN of the Kubernetes cluster"
  value       = digitalocean_kubernetes_cluster.kms_cluster.urn
}
