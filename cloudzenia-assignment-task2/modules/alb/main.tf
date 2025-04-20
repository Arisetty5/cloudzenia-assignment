# Create Application Load Balancer
resource "aws_lb" "app_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids
}

# Create Target Group
resource "aws_lb_target_group" "lb_tg" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

## Create Listener for HTTP
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn          = aws_lb.app_alb.arn # Corrected reference
  port                       = 80
  protocol                   = "HTTP"

  default_action {
    type                     = "forward"
    target_group_arn         = aws_lb_target_group.lb_tg.arn # corrected target group
  }
}

# Create Listener for HTTPS (Port 443)
#resource "aws_lb_listener" "https_listener" {
 # load_balancer_arn          = aws_lb.app_alb.arn
  #port                       = 443
  #protocol                   = "HTTPS"
  #  certificate_arn          = var.https_certificate_arn #  ARN of your SSL certificate (Required for HTTPS)
  #default_action {
   # type                     = "forward"
    #target_group_arn         = aws_lb_target_group.http_tg.arn #  to the HTTP target group initially
  #}
#}


