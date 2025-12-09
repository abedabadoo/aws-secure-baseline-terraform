terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "abu-secure-baseline-tfstate-2025"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "secure-baseline-tflock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
