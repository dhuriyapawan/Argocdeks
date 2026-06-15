# modules/alb/outputs.tf

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "The zone ID of the ALB"
  value       = aws_lb.main.zone_id
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.main.arn
}

output "default_target_group_arn" {
  description = "The ARN of the default target group"
  value       = aws_lb_target_group.default_tg.arn
}
