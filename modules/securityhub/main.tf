# Enable Security Hub for the account
resource "aws_securityhub_account" "this" {
  enable_default_standards = var.enable_default_standards
}

# Explicitly subscribe to AWS Foundational Security Best Practices
# (in case defaults are turned off later)
resource "aws_securityhub_standards_subscription" "fsbp" {
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/aws-foundational-security-best-practices/v/1.0.0"

  depends_on = [aws_securityhub_account.this]
}

data "aws_region" "current" {}
