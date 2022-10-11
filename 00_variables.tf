####################
# Provider
####################
variable "role_arn" {
  description = "AWS Role Arn"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "github_repository_id" {
  description = "GitHub Repository ID"
}

variable "github_access_token" {
  description = "GitHub Access Token"
}

variable "project" {
  description = "Project Name"
}

variable "aws_account_id" {
  description = "AWS Account ID"
}
