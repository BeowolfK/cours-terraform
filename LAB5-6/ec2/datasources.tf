# Datasources pour récupérer les ressources créées par Student X

# Récupérer le subnet privé
data "aws_subnet" "private" {
  filter {
    name   = "tag:Name"
    values = ["student_7_9_Private"]
  }
}

# Récupérer le security group internal
data "aws_security_group" "internal" {
  filter {
    name   = "tag:Name"
    values = ["student_7_9_internal"]
  }
}

# Récupérer le target group nginx
data "aws_lb_target_group" "nginx" {
  name = "student-7-9-nginx-tg"
}

# Récupérer le target group tomcat
data "aws_lb_target_group" "tomcat" {
  name = "student-7-9-tomcat-tg"
}

# Récupérer l'AMI Bitnami Nginx
data "aws_ami" "bitnami_nginx" {
  most_recent = true
  owners      = ["979382823631"]  # Bitnami

  filter {
    name   = "name"
    values = ["bitnami-nginx-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Récupérer l'AMI Bitnami Tomcat
data "aws_ami" "bitnami_tomcat" {
  most_recent = true
  owners      = ["979382823631"]  # Bitnami

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
