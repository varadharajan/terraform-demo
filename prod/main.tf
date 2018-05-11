provider "aws" {
  region = "us-west-1"
}

locals {
  environment = "prod"
}

terraform {
  backend "s3" {
    bucket = "test-terraform-1"
    key    = "web_service_prod"
    region = "us-west-1"
  }
}
