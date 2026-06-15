# modules/ecr/main.tf

# Define repositories for each microservice
variable "services" {
  type    = list(string)
  default = ["frontend", "auth-service", "user-service", "ride-service", "driver-service", "payment-service", "notification-service"]
}

resource "aws_ecr_repository" "repo" {
  count                = length(var.services)
  name                 = "${var.environment}/${var.services[count.index]}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
  }

  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "policy" {
  count      = length(var.services)
  repository = aws_ecr_repository.repo[count.index].name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 30 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
