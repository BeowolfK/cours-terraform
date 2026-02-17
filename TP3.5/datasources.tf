# Datasource pour récupérer l'AMI Amazon Linux 2023 la plus récente
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Datasource pour récupérer le subnet par son ID
data "aws_subnet" "selected" {
  id = var.subnet_id
}

# Datasource pour récupérer le VPC depuis le subnet
data "aws_vpc" "selected" {
  id = data.aws_subnet.selected.vpc_id
}
