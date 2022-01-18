terraform {
  backend "s3" {
    bucket         = "terraform-backend-219106556355"
    key            = "cks-cluster"
    region         = "eu-west-1"
    profile        = "default"
  }
}