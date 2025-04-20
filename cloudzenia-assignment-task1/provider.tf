terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Or a more recent version
    }
  }
}


provider "aws" {
  region = var.region
}
