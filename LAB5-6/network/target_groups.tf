# Target group nginx : regroupe les instances nginx sur le port 80 avec health check
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

# Target group tomcat : regroupe les instances tomcat sur le port 8080 avec health check
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
