output "ipv4_address" {
  description = "ipv4 address of the droplet created"
  value       = digitalocean_droplet.web.ipv4_address
}