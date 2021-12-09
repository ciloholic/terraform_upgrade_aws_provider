resource "aws_cloudfront_distribution" "example" {
  http_version    = "http2"
  price_class     = "PriceClass_200" # Use U.S., Canada, Europe, Asia, Middle East and Africa
  is_ipv6_enabled = true
  enabled         = true

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  origin {
    origin_id   = "${local.service_config.prefix}-private-image"
    domain_name = replace(aws_s3_bucket.private_image.bucket_domain_name, "s3.amazonaws.com", "s3-${local.aws_config.region}.amazonaws.com")

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.example.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = "${local.service_config.prefix}-private-image"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    min_ttl                = 300
    default_ttl            = 300
    max_ttl                = 300
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.service_config.prefix}-cloudfront"
    }
  )
}

resource "aws_cloudfront_origin_access_identity" "example" {}

resource "aws_cloudfront_public_key" "example" {
  name        = "example"
  encoded_key = file("./keys/cloudfront_public_key.pem")
}

# AWS::CloudFront::KeyGroup は未実装の為、一旦は手動で作成
# https://github.com/hashicorp/terraform-provider-aws/issues/15912
