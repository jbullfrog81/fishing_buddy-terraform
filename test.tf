variable "aws_region" {
  type = string
}
variable "aws_profile_name" {
  type = string
}
variable "rds_subnet" {
  type = string
}


provider "aws" {
  profile = var.web_aws_profile_name
  region  = var.web_region
}

resource "aws_subnet" "rds" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.rds_subnet

  tags = {
    Application = "FishingBuddy"
    Envrionment = "Test"
  }
}