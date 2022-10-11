####################
# Parameter
####################
resource "aws_ssm_parameter" "github_personal_access_token" {
  name        = "github-personal-access-token-${var.project}"
  description = "github-personal-access-token-${var.project}"
  type        = "String"
  value       = var.github_access_token
}
