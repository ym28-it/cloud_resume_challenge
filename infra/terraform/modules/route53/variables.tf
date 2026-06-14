variable "domain_name" {
  description = "Domain名"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "CloudFrontのドメイン名"
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "CloudFrontのホストゾーンID"
  type        = string
}
