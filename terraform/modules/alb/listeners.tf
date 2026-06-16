# modules/alb/listeners.tf

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
 
resource "aws_lb_listener" "https" {
  count             = var.enable_https ? 1 : 0
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default_tg.arn
  }
}

resource "aws_lb_listener" "http_fallback" {
  count             = var.enable_https ? 0 : 1
  load_balancer_arn = aws_lb.main.arn
  port              = "8080" # Fallback plain listener
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default_tg.arn
  }
}
