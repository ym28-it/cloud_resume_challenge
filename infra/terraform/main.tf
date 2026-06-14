terraform {
  required_version = ">=1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # 後からS3バックエンドに移行
}

provider "aws" {
  region = var.aws_region
}

# Cloudfront・ACM用（us-east-1固定）
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}


module "dynamodb" {
  source = "./modules/dynamodb"
}

module "iam" {
  source         = "./modules/iam"
  aws_account_id = var.aws_account_id
}

module "s3" {
  source                      = "./modules/s3"
  aws_account_id              = var.aws_account_id
  cloudfront_distribution_id = var.cloudfront_distribution_id
}

module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name

  providers = {
    aws.us_east_1 = aws.us_east_1
  }
}

module "lambda" {
  source          = "./modules/lambda"
  lambda_role_arn = module.iam.lambda_role_arn
}

module "route53" {
  source                    = "./modules/route53"
  domain_name               = var.domain_name
  cloudfront_domain_name    = var.cloudfront_domain_name
  cloudfront_hosted_zone_id = var.cloudfront_hosted_zone_id
}

module "cloudfront" {
  source                         = "./modules/cloudfront"
  domain_name                    = var.domain_name
  s3_bucket_id                   = module.s3.bucket_id
  s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  oac_id                         = var.oac_id
  acm_certificate_arn            = module.acm.certificate_arn
  web_acl_id                     = var.web_acl_id

  providers = {
    aws.us_east_1 = aws.us_east_1
  }
}

module "apigateway" {
  source               = "./modules/apigateway"
  lambda_invoke_arn    = module.lambda.invoke_arn
  lambda_function_name = module.lambda.function_name
}
