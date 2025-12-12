# AWS Secure Baseline (Terraform)

This repo builds a secure-by-default AWS baseline using Terraform.

## Goals
- Least-privilege IAM
- Strong logging/audit trail
- Safe networking defaults
- Encrypted storage
- Easy to extend with modules

## Structure
- `environments/dev` — deployable environment configs
- `modules/` — reusable baseline modules (VPC, IAM, logging, etc.)

## How to use (dev)
```bash
cd environments/dev
terraform init
terraform plan

## Security Hub
Security Hub is intentionally not enabled via Terraform in this repo when using
root credentials. AWS requires an IAM user or role with billing subscription access.
