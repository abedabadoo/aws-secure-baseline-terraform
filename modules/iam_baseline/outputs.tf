output "audit_role_arn" {
  value = aws_iam_role.audit.arn
}

output "mfa_required" {
  value = var.mfa_required
}
