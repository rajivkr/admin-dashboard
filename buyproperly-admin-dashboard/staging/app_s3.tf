resource "aws_s3_bucket" "app_bucket" {
  bucket = var.app_bucket_name

  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "app_bucket_website_configuration" {
  bucket = aws_s3_bucket.app_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_cors_configuration" "app_bucket_cors_configuration" {
  bucket = aws_s3_bucket.app_bucket.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    allowed_headers = ["*"]
  }
}

resource "aws_s3_bucket_policy" "app_bucket_policy" {
  bucket = aws_s3_bucket.app_bucket.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.app_bucket.arn}/*"
        }
    ]
}
EOF
}

