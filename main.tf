provider "aws" {
  region = "us-east-1"  # Specify your desired AWS region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "shubhamdhole122"  # Replace with a unique S3 bucket name
  acl    = "private"      # You can change the ACL as per your requirements

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}
