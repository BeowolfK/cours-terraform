# Récupère le subnet privé créé par Student X via son tag Name
data "aws_subnet" "private" {
  filter {
    name   = "tag:Name"
    values = ["student_7_9_Private"]
  }
}

# Récupère le security group internal créé par Student X
data "aws_security_group" "internal" {
  filter {
    name   = "tag:Name"
    values = ["student_7_9_internal"]
  }
}

# Récupère le target group nginx créé par Student X
data "aws_lb_target_group" "nginx" {
  name = "student-7-9-nginx-tg"
}

# Récupère le target group tomcat créé par Student X
data "aws_lb_target_group" "tomcat" {
  name = "student-7-9-tomcat-tg"
}

# Récupère l'AMI Bitnami Nginx la plus récente
data "aws_ami" "bitnami_nginx" {
  most_recent = true
  owners      = ["979382823631"]

  filter {
    name   = "name"
    values = ["bitnami-nginx-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Récupère l'AMI Bitnami Tomcat la plus récente
data "aws_ami" "bitnami_tomcat" {
  most_recent = true
  owners      = ["979382823631"]

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
