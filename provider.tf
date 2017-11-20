variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "spaces_key" {}
variable "spaces_secret" {}
variable "ssh_fingerprint" {}
variable "lfs_space" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

# Use the AWS provider for DO Spaces
provider "aws" {
  access_key = "${var.spaces_key}"
  secret_key = "${var.spaces_secret}"
  region     = "us-east-1"
  endpoints = {
    s3 = "https://nyc3.digitaloceanspaces.com"
  }
  skip_credentials_validation = true
  skip_get_ec2_platforms = true
  skip_requesting_account_id = true
  skip_metadata_api_check = true
}
