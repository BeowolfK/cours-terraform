# Récupère le VPC existant "Lab5-6" par son tag Name
data "aws_vpc" "lab56" {
  filter {
    name   = "tag:Name"
    values = ["Lab5-6"]
  }
}

# Récupère les zones de disponibilité actives dans la région
data "aws_availability_zones" "available" {
  state = "available"
}
