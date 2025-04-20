resource "aws_alb" "app_alb" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  tags = var.tags
}

# Target Group for WordPress
resource "aws_alb_target_group" "wordpress" {
  name        = "${var.project_name}-wordpress-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = var.tags
}

# Target Group for Microservice
resource "aws_alb_target_group" "microservice" {
  name        = "${var.project_name}-microservice-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = var.tags
}

# HTTP Listener
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.wordpress.arn
  }
}

# Listener Rule for WordPress on HTTP
resource "aws_alb_listener_rule" "wordpress" {
  listener_arn = aws_alb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.wordpress.arn
  }

  condition {
    path_pattern {
      values = ["/wordpress*"]
    }
  }
}

# Listener Rule for Microservice on HTTP
resource "aws_alb_listener_rule" "microservice" {
  listener_arn = aws_alb_listener.http.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.microservice.arn
  }

  condition {
    path_pattern {
      values = ["/microservice*"]
    }
  }
}

# Remove or comment out the HTTPS related resources
# # HTTP Listener - Redirect to HTTPS
# resource "aws_alb_listener" "http_redirect" {
#   load_balancer_arn = aws_alb.app_alb.arn
#   port              = 80
#   protocol          = "HTTP"
#
#   default_action {
#     type = "redirect"
#     redirect {
#       port        = 443
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }
#
# # HTTPS Listener with Routing
# resource "aws_alb_listener" "https" {
#   load_balancer_arn = aws_alb.app_alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#
#   default_action {
#     type = "fixed-response"
#     fixed_response {
#       content_type = "text/plain"
#       message_body = "Not Found"
#       status_code  = "404"
#     }
#   }
# }
#
# # Listener Rule for WordPress
# resource "aws_alb_listener_rule" "wordpress" {
#   listener_arn = aws_alb_listener.https.arn
#   priority     = 100
#
#   action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.wordpress.arn
#   }
#
#   condition {
#     path_pattern {
#       values = ["/wordpress*"]
#     }
#   }
# }
#
# # Listener Rule for Microservice
# resource "aws_alb_listener_rule" "microservice" {
#   listener_arn = aws_alb_listener.https.arn
#   priority     = 200
#
#   action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.microservice.arn
#   }
#
#   condition {
#     path_pattern {
#       values = ["/microservice*"]
#     }
#   }
# }