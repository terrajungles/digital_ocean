output "ipv4_address" {
  description = "ipv4 address of the droplet created"
  value       = module.digital_ocean_web.ipv4_address
}