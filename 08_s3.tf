resource "aws_s3_bucket" "pipeline" {
  bucket = "s3-fargate-${var.project}"
  acl    = "private"
}
