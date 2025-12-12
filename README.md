# AWS Secure Baseline (Terraform)

A secure-by-default AWS baseline built with Terraform. This repo demonstrates practical DevOps + Cloud Security skills:
- Infrastructure-as-Code (Terraform)
- Account logging/auditability (CloudTrail)
- Network segmentation (VPC public/private)
- Configuration tracking (AWS Config)
- IAM hygiene (password policy + audit role)

> Environment shown: **dev**  
> AWS Region: **us-east-1**  
> Terraform state: **S3 backend** (`abu-secure-baseline-tfstate-2025`) with **S3-native locking**

---

## What this deploys

### Modules
- **modules/logging**
  - CloudTrail multi-region trail
  - Encrypted S3 log bucket + required bucket policy
- **modules/vpc**
  - VPC with 2 public + 2 private subnets
  - IGW, NAT Gateway, route tables and associations
- **modules/config**
  - AWS Config recorder + delivery channel
  - Encrypted S3 bucket for config snapshots/history + required bucket policy
- **modules/iam_baseline**
  - Account password policy
  - Read-only audit role (MFA required by default)
- **modules/securityhub** *(optional / currently disabled)*
  - Left in repo but disabled if running Terraform with root credentials

---

## Architecture (high-level)

```mermaid
flowchart TB
  subgraph AWS[ AWS Account ]
    CloudTrail[CloudTrail Trail]
    CTBucket[(S3: CloudTrail Logs)]
    Config[AWS Config Recorder]
    ConfigBucket[(S3: Config Logs)]
    VPC[VPC 10.0.0.0/16]
    Pub1[Public Subnet A]
    Pub2[Public Subnet B]
    Priv1[Private Subnet A]
    Priv2[Private Subnet B]
    IGW[Internet Gateway]
    NAT[NAT Gateway]
    IAM[Audit Role + Password Policy]
  end

  CloudTrail --> CTBucket
  Config --> ConfigBucket

  VPC --> Pub1
  VPC --> Pub2
  VPC --> Priv1
  VPC --> Priv2
  IGW --> Pub1
  NAT --> Pub1
  NAT --> Priv1
  NAT --> Priv2
