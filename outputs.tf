output "bucket_name" {
  value = aws_s3_bucket.my_jenkins_bucket.id
}

# variables.tf
variable "aws_region" {
  default = "us-east-1"
}