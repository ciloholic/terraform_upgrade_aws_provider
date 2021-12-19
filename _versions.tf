terraform {
  required_version = "1.1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.70.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "2.3.1"
    }
  }
}
