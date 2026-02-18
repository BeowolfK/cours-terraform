# Recupere le VPC existant "Lab5-6" par son tag Name
data "aws_vpc" "lab56" {
  filter {
    name   = "tag:Name"
    values = ["Lab5-6"]
  }
}

# Recupere les zones de disponibilite actives dans la region
data "aws_availability_zones" "available" {
  state = "available"
}

