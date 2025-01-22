provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-123456aaa" # Replace with a globally unique name
  acl    = "private"

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Development"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.id
}
