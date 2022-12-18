terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      Version = "~>3.27"
    }
  }

  required_version = ">=0.14.9"
  backend "s3" {
    bucket = "tf-state-05"
    key    = "tfdemo.state"
    region = "ap-south-1"
  }

}

provider "aws" {
  version = "~>3.0"
  region  = "ap-south-1"
}

variable "s3_bucket_name" {
  default     = "sonu-storage-bkt"
  type        = string
  description = "S3 bucket name"
}
resource "aws_s3_bucket" "s3Bucket" {
  bucket = var.s3_bucket_name
  acl    = "public-read"
  policy = <<EOF
{
     "id" : "MakePublic",
   "version" : "2012-10-17",
   "statement" : [
      {
         "action" : [
             "s3:GetObject"
          ],
         "effect" : "Allow",
         "resource" : "arn:aws:s3:::${var.s3_bucket_name}/*",
         "principal" : "*"
      }
    ]
  }
EOF

  website {
    index_document = "index.html"
  }
}
