terraform {
  required_version = ">= 0.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "ash-terraform-state-bucket"
    key    = "state/terraform_state.tfstate"
    region = "us-east-1"
  }
}
