provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

resource "aws_s3_bucket" "my_jenkins_bucket" {
  bucket = "dholeshubham1234" # Replace with a globally unique bucket name
  acl    = "private"

  tags = {
    Name        = "Jenkins S3 Bucket"
    Environment = "Dev"
  }
}