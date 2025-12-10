output "cloudtrail_bucket_name" {
  value = aws_s3_bucket.cloudtrail_logs.bucket
}

output "cloudtrail_name" {
  value = aws_cloudtrail.main.name
}
