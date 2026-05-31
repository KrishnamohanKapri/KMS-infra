variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "DigitalOcean region (e.g., nyc1, sfo3, fra1, sgp1)"
  type        = string
  default     = "nyc1"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "kms"
}

variable "ssh_public_key" {
  description = "SSH public key for Droplets"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for DOKS cluster (check with: doctl kubernetes options versions)"
  type        = string
  default     = "1.31.1-do.0"
}

variable "node_size" {
  description = "Droplet size for Kubernetes nodes (e.g., s-2vcpu-4gb, s-4vcpu-8gb)"
  type        = string
  default     = "s-2vcpu-4gb" # $24/month - adjust based on budget
}

variable "node_count" {
  description = "Number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "enable_bastion" {
  description = "Enable bastion droplet creation"
  type        = bool
  default     = true
}

variable "github_username" {
  description = "GitHub username for GHCR authentication"
  type        = string
  default     = "krishnamohankapri"
}

variable "github_pat" {
  description = "GitHub Personal Access Token for GHCR (sensitive). Leave empty to skip GHCR secret creation."
  type        = string
  sensitive   = true
  default     = ""
}

variable "enable_ansible_provisioning" {
  description = "Enable Ansible provisioning after cluster creation"
  type        = bool
  default     = true
}

variable "gitops_repo_path" {
  description = "GitOps repository - GitHub URL (e.g., https://github.com/user/repo) or local path (e.g., ../KMS-gitops)"
  type        = string
  default     = "https://github.com/KrishnamohanKapri/KMS-gitops"
}

variable "gitops_repo_branch" {
  description = "Git branch for GitHub URL (ignored for local paths)"
  type        = string
  default     = "main"
}