variable "domain_name" {
  description = "Domain Name"
  type        = string
}

variable "s3_bucket_id" {
  description = "S3バケットID"
  type        = string
}

variable "s3_bucket_regional_domain_name" {
  description = "S3バケットのリージョンドメイン名"
  type        = string
}

variable "oac_id" {
  description = "CloudFront OACのID"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM証明書のARN"
  type        = string
}

variable "web_acl_id" {
  description = "WAF Web ACLのARN"
  type        = string
}
