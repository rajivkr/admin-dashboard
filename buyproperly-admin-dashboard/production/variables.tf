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

variable "pipeline_bucket_name" {
  default     = "buyproperly-admin-dashboard-pipeline"
  description = "pipeline bucket name"
}

variable "app_bucket_name" {
  default     = "buyproperly-admin-dashboard-app"
  description = "app bucket name"
}

variable "projectname" {
  default     = "buyproperly-admin-dashboard"
  description = "pipeline project name"
}

variable "repo_id" {
  default     = "BuyProperly/buyproperly-admin-dashboard"
  description = "github repository id"
}

variable "repo_branch_name" {
  default     = "main"
  description = "github branch name"
}

variable "connection_arn" {
  type        = string
  description = "Arn for the CodeStar Connection"
  default     = "arn:aws:codestar-connections:ca-central-1:583121241284:connection/a4527acc-cb8f-4954-ac95-73c5fa038785"
}
