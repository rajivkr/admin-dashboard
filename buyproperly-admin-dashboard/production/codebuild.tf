resource "aws_codebuild_project" "codebuild" {
  name         = "${var.projectname}-codebuild"
  description  = "code build project"
  service_role = aws_iam_role.codebuild_role1.arn



  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "STAGE"
      value = "production"
    }
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type = "CODEPIPELINE"
  }
}
