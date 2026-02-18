# Recupere le VPC existant "Lab5-6"
data "aws_vpc" "lab56" {
  filter {
    name   = "tag:Name"
    values = ["Lab5-6"]
  }
}

# Recupere les zones de disponibilite actives
data "aws_availability_zones" "available" {
  state = "available"
}

# Recupere le security group RDS cree par Student A
data "aws_security_group" "rds" {
  filter {
    name   = "tag:Name"
    values = ["student_7_9_rds"]
  }
}

# Recupere les parametres SSM crees par Student A
data "aws_ssm_parameter" "db_endpoint" {
  name = "/lab6/db/endpoint"
}

data "aws_ssm_parameter" "db_name" {
  name = "/lab6/db/name"
}

# AMI Amazon Linux 2 (derniere version)
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
