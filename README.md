# aws-secure-baseline-terraform
Secure AWS baseline using Terraform (IAM, logging, network, storage)
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
