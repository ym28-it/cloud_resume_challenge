resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases             = [var.domain_name]
  http_version        = "http2"
  price_class         = "PriceClass_All"
  tags = {
    "Name" = "crc-resume-distro"
  }

  web_acl_id = var.web_acl_id

  origin {
    domain_name              = "${var.s3_bucket_id}.s3.ap-northeast-1.amazonaws.com"
    origin_id                = "${var.s3_bucket_id}.s3.ap-northeast-1.amazonaws.com-mnv6pzaltys"
    origin_access_control_id = var.oac_id
  }

  default_cache_behavior {
    target_origin_id       = "${var.s3_bucket_id}.s3.ap-northeast-1.amazonaws.com-mnv6pzaltys"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = data.aws_cloudfront_cache_policy.caching_optimized.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}
