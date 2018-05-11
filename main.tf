provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "test-terraform-1"
    key    = "web_service"
    region = "us-west-1"
  }
}
