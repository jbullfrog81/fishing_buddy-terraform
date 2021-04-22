###
# VARIABLES
###
variable "aws_region" {
  type = string
}
variable "aws_profile_name" {
  type = string
}
variable "rds_subnet1" {
  type = string
}
variable "rds_subnet2" {
  type = string
}
variable "vpc_cidr" {
  type = string
}


###
# PROVIDERS
###
provider "aws" {
  profile = var.aws_profile_name
  region  = var.aws_region
}


###
# RESOURCES
###

resource "aws_vpc" "FishingBuddy_vpc" {
  cidr_block         = var.vpc_cidr
  instance_tenancy   = "default"
  enable_dns_support = true
  
  tags = {
    Application = "FishingBuddy"
    Envrionment = "dev"
    Name = "FishingBuddy_vpc"
  }

}

resource "aws_subnet" "rds_subnet_1" {
  vpc_id            = aws_vpc.FishingBuddy_vpc.id
  cidr_block        = var.rds_subnet1

  tags = {
    Application = "FishingBuddy"
    Envrionment = "dev"
    Name = "rds_subnet_1-dev"
  }
}

resource "aws_subnet" "rds_subnet_2" {
  vpc_id            = aws_vpc.FishingBuddy_vpc.id
  cidr_block        = var.rds_subnet2

  tags = {
    Application = "FishingBuddy"
    Envrionment = "dev"
    Name = "rds_subnet_2-dev"
  }
}

resource "aws_s3_bucket" "FishingBuddy_Terraform_State" {
  bucket     = "fishingbuddy-tf-state-bucket"
  acl        = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "Fishing Buddy Terraform State Bucket"
    Environment = "Dev"
  }
}

###
# DATA
###

data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    # Replace this with your bucket name!
    bucket = "terraform-up-and-running-state"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"
  }
}

###
# OUTPUT
###