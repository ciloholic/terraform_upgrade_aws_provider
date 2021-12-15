terraform {
  required_version = "1.0.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.69.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2"
    }
  }
}
