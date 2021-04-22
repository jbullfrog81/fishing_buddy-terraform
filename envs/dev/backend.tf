terraform {
  backend "s3" {
      bucket = "fishingbuddy-tf-state-bucket"
      key = "terraform/state/dev"
      region = "us-west-2"
  }
}
