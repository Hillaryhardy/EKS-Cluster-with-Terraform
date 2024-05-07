terraform {
  backend "s3" {
    bucket = "ht-app"
    region = "eu-north-1"
    key = "eks/terraform.tfstate"
  }
}