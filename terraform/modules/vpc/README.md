# VPC Terraform Module

This module sets up the primary networking for a target environment.

## Resources Created

- 1 AWS VPC
- Internet Gateway
- Public Subnets (with EKS elb tags)
- Private Subnets (with EKS internal-elb tags)
- Database Subnets (isolated)
- NAT Gateway(s) and EIP(s)
- Custom Route Tables and Associations
