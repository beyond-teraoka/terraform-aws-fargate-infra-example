####################
# IAM Role
####################
resource "aws_iam_role" "fargate_task_execution" {
  name               = "role-fargate-task-${var.project}-execution"
  assume_role_policy = file("./roles/fargate_task_assume_role.json")
}

resource "aws_iam_role" "codebuild_service_role" {
  name               = "role-codebuild-service-${var.project}-role"
  assume_role_policy = file("./roles/codebuild_assume_role.json")
}

resource "aws_iam_role" "codepipeline_service_role" {
  name               = "role-codepipeline-service-${var.project}-role"
  assume_role_policy = file("./roles/codepipeline_assume_role.json")
}

####################
# IAM Role Policy
####################
resource "aws_iam_role_policy" "fargate_task_execution" {
  name   = "execution-policy"
  role   = aws_iam_role.fargate_task_execution.name
  policy = file("./roles/fargate_task_execution_policy.json")
}

resource "aws_iam_role_policy" "codebuild_service_role" {
  name   = "build-policy"
  role   = aws_iam_role.codebuild_service_role.name
  policy = file("./roles/codebuild_build_policy.json")
}

resource "aws_iam_role_policy" "codepipeline_service_role" {
  name   = "pipeline-policy"
  role   = aws_iam_role.codepipeline_service_role.name
  policy = file("./roles/codepipeline_pipeline_policy.json")
}
