variable "aws_account_id" {
  description = "AWS Account Id"
  type        = string
  sensitive   = true
}

variable "cloudfront_distoribution_id" {
  description = "CloudFront DistributionID"
  type        = string
}
