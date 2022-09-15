variable "region" {
  description = "AWS Region"
  default     = "ca-central-1"
}

variable "access_key" {
  description = "access key"
}

variable "secret_key" {
  description = "secret key"
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_codestarconnections_connection" "buypropery_admin_github" {
  name          = "buyproperly-admin-pipeline"
  provider_type = "GitHub"
}
