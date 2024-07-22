resource "aws_s3_bucket" "pipeline_bucket" {
  bucket        = var.pipeline_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.pipeline_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
