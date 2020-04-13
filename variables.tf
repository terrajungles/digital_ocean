variable "do_token" {
  type        = string
  description = "DigitalOcean Token"
}

variable "name" {
  type        = string
  description = "Name of the droplet"
}

variable "image" {
  type        = string
  description = "Image for the droplet"
  default     = "ubuntu-18-04-x64"
}

variable "region" {
  type        = string
  description = "Region of the droplet and setup"
  default     = "sgp1"
}

variable "plan" {
  type        = string
  default     = "s-1vcpu-1gb"
  description = "Digital Ocean droplet plan slug"
}

variable "volume_size" {
  type        = number
  default     = 10
  description = "Size of the digital ocean droplet in GB"
}

variable "startup_script" {
  type        = string
  description = "Startup script text"
}