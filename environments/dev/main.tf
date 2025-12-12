provider "aws" {
  region  = var.aws_region
  profile = "secure-baseline-dev"
}
module "logging" {
  source = "../../modules/logging"

  project_name = var.project_name
  environment  = var.environment
}

module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
}

module "config" {
  source = "../../modules/config"

  project_name = var.project_name
  environment  = var.environment
}

# module "securityhub" {
#   source = "../../modules/securityhub"
# }

module "iam_baseline" {
  source = "../../modules/iam_baseline"

  project_name = var.project_name
  environment  = var.environment
  mfa_required = true
}
