

resource "aws_cloudfront_distribution" "struts_cf" {
  origin {
    domain_name = "${aws_elb.struts-pt-elb.dns_name}"
    origin_id   = "strutsOrigin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2", "SSLv3"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloudfront distribution for JAVA struts application"
  web_acl_id          = "${aws_waf_web_acl.tm_waf_rule_acl.id}"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "strutsOrigin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


resource "aws_waf_web_acl" "tm_waf_rule_acl" {
  name = "Trendmicro-Managed-Rule-ACL"
  metric_name = "TrendmicroManagedRuleACLmetrics"
  default_action {
    type = "ALLOW"
  }
}