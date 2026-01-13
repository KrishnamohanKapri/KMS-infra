output "droplet_id" {
  description = "ID of the Droplet"
  value       = digitalocean_droplet.bastion.id
}

output "droplet_public_ip" {
  description = "Public IP of the Droplet"
  value       = digitalocean_droplet.bastion.ipv4_address
}

output "droplet_private_ip" {
  description = "Private IP of the Droplet"
  value       = digitalocean_droplet.bastion.ipv4_address_private
}
