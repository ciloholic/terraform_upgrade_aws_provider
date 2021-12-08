data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

variable "aws_access_key" {
  type      = string
  sensitive = true
}
variable "aws_secret_key" {
  type      = string
  sensitive = true
}
variable "service_name" {
  type = string
}
variable "env" {
  type = string
}

locals {
  common_tags = {
    Project     = var.service_name
    Environment = var.env
    Management  = "Terraform"
  }
  service_config = {
    name   = var.service_name
    env    = var.env
    prefix = "${var.service_name}-${var.env}"
  }
  aws_config = {
    aws_account_id = data.aws_caller_identity.current.account_id
    region         = data.aws_region.current.name
  }
}
