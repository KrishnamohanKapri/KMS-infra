# Ansible Playbook for DOKS Cluster Configuration

This Ansible playbook automates the post-deployment configuration of the DigitalOcean Kubernetes (DOKS) cluster.

## What it does

1. **Gets kubeconfig** - Configures kubectl to access the cluster
2. **Creates namespaces** - Creates `kms`, `monitoring`, and `argocd` namespaces
3. **Sets up GHCR secrets** - Creates image pull secrets for GitHub Container Registry
4. **Installs Argo CD** - Deploys Argo CD for GitOps
5. **Installs Gateway API** - Installs Gateway API CRDs and Envoy Gateway
6. **Deploys Argo CD applications** - Applies Argo CD application manifests from GitOps repo

## Prerequisites

- Ansible installed
- `kubectl` installed
- `doctl` installed and authenticated
- GitHub Personal Access Token (for GHCR secrets)

## Usage

### Manual execution

```bash
cd /home/krish/Projects/KMS/KMS-infra/ansible

# Set GitHub PAT (optional, if you want GHCR secrets)
export GITHUB_PAT="your_github_pat_token"

# Run playbook
ansible-playbook -i inventory.yml configure-doks.yml \
  -e cluster_name=kms-cluster \
  -e github_username=krishnamohankapri \
  -e gitops_repo_path=../KMS-gitops
```

### Automatic execution via Terraform

The playbook runs automatically after `terraform apply` completes (if `enable_ansible_provisioning = true`).

## Configuration

Edit `group_vars/all.yml` to customize:
- Cluster name
- Namespaces
- Argo CD version
- Gateway API version
- GitOps repository path

## Variables

### Required
- `cluster_name` - Name of the DOKS cluster

### Optional
- `github_username` - GitHub username for GHCR
- `github_pat` - GitHub PAT (from environment variable `GITHUB_PAT`)
- `gitops_repo_path` - Path to GitOps repository

## Troubleshooting

### "kubectl not found"
Install kubectl:
```bash
# Linux
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

### "doctl not found"
Install doctl:
```bash
cd ~
wget https://github.com/digitalocean/doctl/releases/download/v1.104.0/doctl-1.104.0-linux-amd64.tar.gz
tar xf doctl-1.104.0-linux-amd64.tar.gz
sudo mv doctl /usr/local/bin
```

### "GitHub PAT not set"
If you don't set `GITHUB_PAT`, the playbook will skip GHCR secret creation. This is fine if you're using public images or have other authentication methods.

### "Argo CD not ready"
The playbook waits up to 5 minutes for Argo CD to be ready. If it times out, check:
```bash
kubectl get pods -n argocd
kubectl describe deployment argocd-server -n argocd
```

## File Structure

```
ansible/
├── inventory.yml          # Ansible inventory
├── configure-doks.yml     # Main playbook
├── group_vars/
│   └── all.yml           # Default variables
└── README.md             # This file
```
