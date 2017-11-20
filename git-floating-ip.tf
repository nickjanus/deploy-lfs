resource "digitalocean_floating_ip" "git-floating-ip" {
  droplet_id = "${digitalocean_droplet.git-server.id}"
  region     = "${digitalocean_droplet.git-server.region}"
}
