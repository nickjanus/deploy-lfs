resource "digitalocean_volume" "git-volume" {
  description = "Volume used to store git server data"
  name = "git-volume"
  size = 10
  region = "nyc3"
}
