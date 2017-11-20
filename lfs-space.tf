resource "aws_s3_bucket" "lfs-space" {
  bucket = "${var.lfs_space}"
  acl    = "private"
}
