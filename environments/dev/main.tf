provider "aws" {
  region  = var.aws_region
  profile = "secure-baseline-dev"
}
module "logging" {
  source = "../../modules/logging"

  project_name = var.project_name
  environment  = var.environment
}
