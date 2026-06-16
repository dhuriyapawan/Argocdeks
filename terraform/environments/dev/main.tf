# terraform/environments/dev/main.tf

data "aws_caller_identity" "current" {}

locals {
  environment = "dev"
  tags = {
    Environment = local.environment
    Project     = "RideShareX"
    ManagedBy   = "Terraform"
  }
}

# 1. VPC Module
module "vpc" {
  source = "../../modules/vpc"

  environment           = local.environment
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  availability_zones    = var.availability_zones
  single_nat_gateway    = true
  tags                  = local.tags
}

# 2. KMS Key Module
module "kms" {
  source = "../../modules/kms"

  environment = local.environment
  account_id  = data.aws_caller_identity.current.account_id
  tags        = local.tags
}

# 3. Security Groups Module
module "security_groups" {
  source = "../../modules/security-groups"

  environment = local.environment
  vpc_id      = module.vpc.vpc_id
  tags        = local.tags
}

# 4. IAM Roles Module
module "iam" {
  source = "../../modules/iam"

  environment       = local.environment
  # oidc_provider_arn = module.eks.oidc_provider_arn
  # oidc_provider_url = module.eks.oidc_provider_url
  tags              = local.tags
}

# 5. ALB Module
module "alb" {
  source = "../../modules/alb"

  environment       = local.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
  security_group_id = module.security_groups.alb_sg_id
  enable_https      = false # HTTPS disabled by default for dev environments without valid DNS Certs
  tags              = local.tags
}

# 6. EKS Cluster Module
module "eks" {
  source = "../../modules/eks"

  environment               = local.environment
  cluster_version           = var.cluster_version
  cluster_role_arn          = module.iam.eks_cluster_role_arn
  node_role_arn             = module.iam.eks_node_role_arn
  private_subnet_ids        = module.vpc.private_subnets
  cluster_security_group_id = module.security_groups.eks_cluster_sg_id
  kms_key_arn               = module.kms.key_arn
  cluster_role_dependency   = module.iam.eks_cluster_role_arn
  system_node_desired_size  = 1
  system_node_max_size      = 2
  system_node_min_size      = 1
  app_node_desired_size     = 1
  app_node_max_size         = 3
  app_node_min_size         = 1
  tags                      = local.tags
}

# 7. ECR Registries
module "ecr" {
  source = "../../modules/ecr"

  environment = local.environment
  tags        = local.tags
}

# 8. RDS PostgreSQL Database
module "rds" {
  source = "../../modules/rds"

  environment         = local.environment
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  db_name             = "rideshare"
  username            = "dbadmin"
  password            = var.db_password
  database_subnet_ids = module.vpc.database_subnets
  security_group_id   = module.security_groups.rds_sg_id
  kms_key_arn         = module.kms.key_arn
  multi_az            = false
  skip_final_snapshot = true
  tags                = local.tags
}

# 9. Redis Cache
module "redis" {
  source = "../../modules/redis"

  environment         = local.environment
  node_type           = "cache.t3.micro"
  num_cache_clusters  = 1
  database_subnet_ids = module.vpc.database_subnets
  security_group_id   = module.security_groups.redis_sg_id
  auth_token          = var.redis_auth_token
  kms_key_arn         = module.kms.key_arn
  tags                = local.tags
}

# 10. Route53 Hosted Zone & Records
module "route53" {
  source = "../../modules/route53"

  environment  = local.environment
  domain_name  = var.domain_name
  subdomain    = "dev"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
  tags         = local.tags
}
