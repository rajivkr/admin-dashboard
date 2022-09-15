terraform {
  required_version = ">= 0.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "buyproperly-admin-dashboard-terraform-state"
    key    = "staging/state/terraform_state.tfstate"
    # @TODO: Use below key for production
    # key    = "production/state/terraform_state.tfstate"
    region = "ca-central-1"
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

