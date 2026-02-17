# Target Group pour Nginx
resource "aws_lb_target_group" "nginx" {
  name     = "student-7-9-nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.lab56.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
  }

  tags = {
    Name = "student-7-9-nginx-tg"
  }
}

# Target Group pour Tomcat
resource "aws_lb_target_group" "tomcat" {
  name     = "student-7-9-tomcat-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.lab56.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
  }

  tags = {
    Name = "student-7-9-tomcat-tg"
  }
}
