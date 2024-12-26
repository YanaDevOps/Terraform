terraform {
  backend "s3" {
    bucket = "terrabucket666"
    key    = "terraform/backend"
    region = "us-west-1"
  }
}