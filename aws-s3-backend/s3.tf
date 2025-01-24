resource "aws_s3_bucket" "state" {
  bucket_prefix = "${var.prefix}-state-"
  force_destroy = var.force_destroy

  # lifecycle {
  #   prevent_destroy = true
  # }
  tags = {
    Name = "${var.prefix}-state"
  }
}
# trig

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "access_control" {
  bucket = aws_s3_bucket.state.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:*",
        "Resource" : "${aws_s3_bucket.state.arn}/*",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceArn" = var.approved_arns
          }
        }
      }
    ]
  })
}

