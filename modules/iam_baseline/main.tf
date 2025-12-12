locals {
  name = "${var.project_name}-${var.environment}"
}

# Strong-ish password policy (applies account-wide)
resource "aws_iam_account_password_policy" "this" {
  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 24
  hard_expiry                    = false
}

# Read-only "audit" role you can assume (handy for clients / security reviews)
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = ["sts:AssumeRole"]

    dynamic "condition" {
      for_each = var.mfa_required ? [1] : []
      content {
        test     = "Bool"
        variable = "aws:MultiFactorAuthPresent"
        values   = ["true"]
      }
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "audit" {
  name               = "${local.name}-audit-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Attach AWS-managed ReadOnlyAccess
resource "aws_iam_role_policy_attachment" "readonly" {
  role       = aws_iam_role.audit.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
