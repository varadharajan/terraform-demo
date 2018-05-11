provider "aws" {
  region = "us-west-1"
  version = "~> 1.18"
}

locals {
  environment = "stag"
}

terraform {
  backend "s3" {
    bucket = "test-terraform-1"
    key    = "web_service_stag"
    region = "us-west-1"
  }
}
