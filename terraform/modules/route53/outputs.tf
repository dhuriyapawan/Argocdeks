# modules/route53/outputs.tf

output "hosted_zone_id" {
  description = "The zone ID of the Route53 hosted zone"
  value       = aws_route53_zone.primary.zone_id
}

output "hosted_zone_name" {
  description = "The name of the Route53 hosted zone"
  value       = aws_route53_zone.primary.name
}

output "nameservers" {
  description = "Nameservers of the hosted zone"
  value       = aws_route53_zone.primary.name_servers
}
