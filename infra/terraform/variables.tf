variable "aws_region" {
  description = "メインリージョン"
  type        = string
  default     = "ap-northeast-1"
}

variable "aws_account_id" {
  description = "AWSアカウントID"
  type        = string
  sensitive   = true
}

variable "domain_name" {
  description = "カスタムドメイン名"
  type        = string
}

variable "project_name" {
  description = "プロジェクト名プレフィックス"
  type        = string
  default     = "crc"
}

variable "cloudfront_distribution_id" {
  description = "CloudFront DistributionID"
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

variable "oac_id" {
  description = "CloudFront OACのID"
  type        = string
}

variable "web_acl_id" {
  description = "WAF Web ACLのARN"
  type        = string
}
