# creates a bucket where statefile while be stored
terraform {
  backend "s3" {
    bucket = "ht-bucket-app"
    region = "eu-north-1"
    key = "jenkins-server/terraform.tfstate"
  }
}