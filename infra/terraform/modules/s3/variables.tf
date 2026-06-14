variable "aws_account_id" {
  description = "AWS Account Id"
  type        = string
  sensitive   = true
}

variable "cloudfront_distribution_id" {
  description = "CloudFront DistributionID"
  type        = string
}
