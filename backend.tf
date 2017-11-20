terraform {
  backend "s3" {
    key    = "lfs-deployment/terraform.tfstate"
    region = "us-east-1" # This fields is a throwaway since the backend is provided by DO
    endpoint = "https://nyc3.digitaloceanspaces.com"
    skip_credentials_validation = true
    skip_get_ec2_platforms = true
    skip_requesting_account_id = true
    skip_metadata_api_check = true
  }
}
