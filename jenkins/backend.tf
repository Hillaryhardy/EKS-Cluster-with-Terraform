terraform {
  backend "s3" {
    bucket = "ht-bucket-app"
    region = "eu-north-1"
    key = "eks/terraform.tfstate"
  }
}