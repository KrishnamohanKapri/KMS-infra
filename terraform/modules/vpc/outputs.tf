output "vpc_id" {
  description = "ID of the VPC"
  value       = digitalocean_vpc.kms_vpc.id
}

output "vpc_uuid" {
  description = "UUID of the VPC"
  value       = digitalocean_vpc.kms_vpc.id
}
