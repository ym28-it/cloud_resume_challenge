# AWS Resource List

Cloud Resume ChallengeにおけるAWSリソースの構成を棚卸しする。

## S3

- bucket name: crc-resume-hosting
- region: ap-northeast-1
- public access block: all block ON
- versioning: false
- lifecycle: None

### Bucket Policy

```json
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::crc-resume-hosting/*",
            "Condition": {
                "ArnLike": {
                    "AWS:SourceArn": "arn:aws:cloudfront::730665637612:distribution/ED30K9WJ2HFET"
                }
            }
        }
    ]
}
```

## CloudFront

- distribution id: ED30K9WJ2HFET
- domain name: d1rpui1whpyhwe.cloudfront.net
- aliases domain name: crc-prac.com 
- certificate arn: arn:aws:acm:us-east-1:730665637612:certificate/4d0dd854-d198-401a-9011-8cba8968415e
- origin: crc-resume-hosting
- OAC id: 

## Route53

- host zone id: Z07823863R7CKSU3B2J1X
- type: pablic host zone
- domain: crc-prac.com
- records: A, AAAA

## API Gateway

- resource name: VisitorCounterOperations
- id: ecc0f26w0k
- protocol: REST
- endpoint type: region

### resource

/visitor-counter

method1:

- type: OPTIONS
- integration type: Mock

method2:

- type: POST
- integration type: Lambda

## IAM

### Role

- crc-prac-labmda-role

### Policy

- crc-prac-lambda-policy
  - service: DynamoDB
  - access level: write only
  - resource region: ap-northeast-1
  - resource TableName: crc-prac-db

## ACM

- certificate arn: arn:aws:acm:us-east-1:730665637612:certificate/4d0dd854-d198-401a-9011-8cba8968415e
- region: us-east-1
- validation method: DNS

## Lambda

- name: visitor_counter
- package type: Zip
- runtime: python 3.12
- execute role: crc-prac-lambda-role
- trigger: API Gateway: VisitorCounterOperations

## DynamoDB

- name: crc-prac-db
- pertision key: id(String)
- capacity mode: on-demand

