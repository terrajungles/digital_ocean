provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "web" {
  image  = var.image
  name   = var.name
  region = var.region
  size   = var.plan

  user_data = var.startup_script

  depends_on = [digitalocean_volume.database]
}

resource "digitalocean_volume" "database" {
  name                     = local.volume_name
  region                   = var.region
  size                     = var.volume_size
  initial_filesystem_type  = "ext4"
  initial_filesystem_label = "database"
  description              = "Volume to store Postgres Data"
}

resource "digitalocean_volume_attachment" "web_volume_attachment" {
  droplet_id = digitalocean_droplet.web.id
  volume_id  = digitalocean_volume.database.id
}

resource "digitalocean_firewall" "web" {
  name = "standard-web-firewall"

  droplet_ids = [digitalocean_droplet.web.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

locals {
  volume_name = "database-disk"
}