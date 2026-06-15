# modules/route53/main.tf

resource "aws_route53_zone" "primary" {
  name    = var.domain_name
  comment = "Hosted zone for RideShareX ${var.environment}"

  tags = var.tags
}
