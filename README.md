
# terraform-cloudfront-auth 


 

---

## Introduction

A Terraform module to provision s3 static web hosting using cloudfront distribution with basic auth


## Usages

terraform apply


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket_name | The name of your S3 bucket | string | web-hosting-basic-auth | yes |
| cloudfront_distribution | The FQDN of your cloudfront distribution you want to use to serve your private content (e.g www.example.com) | string | web-hosting-basic-auth-dist | yes |
| cloudfront_price_class | Cloudfront price classes: `PriceClass_All`, `PriceClass_200`, `PriceClass_100` | string | `PriceClass_All` | no |
| cloudfront_default_root_object | The default root object of the Cloudfront distribution | string | `index.html` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3_bucket | The name of the S3 Bucket |
| cloudfront_arn | ARN of the Cloudfront Distribution |
| cloudfront_id | ID of the Cloudfront Distribution |




