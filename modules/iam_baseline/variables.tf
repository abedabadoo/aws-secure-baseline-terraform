variable "project_name" {
  type        = string
  description = "Prefix for resources"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "mfa_required" {
  type        = bool
  description = "Require MFA to assume the audit role"
  default     = true
}
