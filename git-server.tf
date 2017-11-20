resource "digitalocean_droplet" "git-server" {
  image = "ubuntu-16-04-x64"
  name = "git-server"
  region = "nyc3"
  size = "512mb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  volume_ids = ["${digitalocean_volume.git-volume.id}"]

  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt-get -y install nginx gnupg",
      "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB",
      "curl -sSL https://get.rvm.io | bash -s stable",
      "rvm install ruby-2.2.3",
      "rvm use ruby-2.2.3",
      "mkdir -p /etc/nginx/main.d",

      "systemctl restart nginx.service"
    ]
  }
}

