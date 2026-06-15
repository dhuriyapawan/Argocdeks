# modules/route53/records.tf

resource "aws_route53_record" "alb_alias" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.subdomain != "" ? "${var.subdomain}.${var.domain_name}" : var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
