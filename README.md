# learn-terraform

Terraform configuration for deploying AWS infrastructure including VPC networking, EC2 instances, and IAM resources.

## Overview

This project provisions a multi-tier AWS environment with:

- Custom VPC (10.0.0.0/16) with 2 public and 2 private subnets across availability zones
- Web server instance in public subnet with Apache auto-configured via user data
- Database instance in private subnet with no public IP
- Security groups allowing SSH (port 22) and HTTP (port 80)
- Dynamically generated SSH key pair for instance access
- IAM user with administrator access and programmatic credentials

## Project Structure

| File | Description |
|------|-------------|
| `provider.tf` | AWS provider configuration (us-east-1) |
| `networking.tf` | VPC, subnets, internet gateway, route tables |
| `security.tf` | Security groups, SSH key generation |
| `compute.tf` | EC2 instances (web server and database) |
| `iam.tf` | IAM user and access credentials |
| `outputs.tf` | Output values for IAM credentials |
| `whoami.tf` | AWS caller identity data source |
| `user_data.sh` | Apache installation and configuration script |

## Prerequisites

- Terraform installed
- AWS CLI configured with valid credentials

## Usage

Initialize Terraform:
```bash
terraform init
```

Review the planned changes:
```bash
terraform plan
```

Deploy the infrastructure:
```bash
terraform apply
```

Retrieve sensitive outputs (IAM credentials):
```bash
terraform output iam_user_password
terraform output iam_user_access_key_secret
```

Destroy the infrastructure:
```bash
terraform destroy
```

## Outputs

- `public_webserver_ip` - Public IP address of the web server
- `private_database_ip` - Private IP address of the database server
- `current_user_arn` - ARN of the AWS caller identity
- `am_user_name` - IAM user name
- `iam_user_access_key_id` - IAM user access key ID
- `iam_user_password` - IAM user console password (sensitive)
- `iam_user_access_key_secret` - IAM user access key secret (sensitive)

## SSH Access

The SSH private key is automatically generated and saved as `devops-ssh-key.pem` with proper permissions (0400).

Connect to the web server:
```bash
ssh -i devops-ssh-key.pem ubuntu@<public_webserver_ip>
```

## Notes

- Web server is accessible via HTTP at `http://<public_webserver_ip>`
- Database server has no public IP and is only accessible from within the VPC
- IAM user is created with full administrator access
- **If you already have an IAM user configured**, comment out the contents of `iam.tf` and related outputs in `outputs.tf` to avoid conflicts