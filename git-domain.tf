resource "digitalocean_domain" "git-domain" {
  name = "git.sugarman.life"
  ip_address = "${digitalocean_floating_ip.git-floating-ip.ip_address}"
}
