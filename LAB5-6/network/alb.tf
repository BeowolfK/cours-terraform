# Application Load Balancer
resource "aws_lb" "main" {
  name               = "student-7-9-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  enable_deletion_protection = false

  tags = {
    Name = "student-7-9-alb"
  }
}

# Listener sur port 80 avec action par défaut 404
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: Not Found"
      status_code  = "404"
    }
  }
}

# Règle : Si path = "/nginx" → forward vers nginx target group
resource "aws_lb_listener_rule" "nginx" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

  condition {
    path_pattern {
      values = ["/nginx*"]
    }
  }
}

# Règle : Si path = "/tomcat" → forward vers tomcat target group
resource "aws_lb_listener_rule" "tomcat" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tomcat.arn
  }

  condition {
    path_pattern {
      values = ["/tomcat*"]
    }
  }
}
