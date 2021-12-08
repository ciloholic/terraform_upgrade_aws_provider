resource "aws_s3_bucket" "private_image" {
  bucket        = "${local.service_config.prefix}-private-image"
  acl           = "private"
  force_destroy = false

  tags = merge(
    local.common_tags,
    {
      Name = "${local.service_config.prefix}-private-image"
    }
  )

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "private_image" {
  bucket                  = aws_s3_bucket.private_image.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "private_image" {
  depends_on = [aws_s3_bucket_public_access_block.private_image]
  bucket     = aws_s3_bucket.private_image.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "s3:GetObject",
        "Principal" : {
          "AWS" : "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.example.id}"
        },
        "Resource" : "arn:aws:s3:::${aws_s3_bucket.private_image.bucket}/*"
      }
    ]
  })
}
