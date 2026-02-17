# Datasource pour récupérer le VPC "Lab5-6"
data "aws_vpc" "lab56" {
  filter {
    name   = "tag:Name"
    values = ["Lab5-6"]
  }
}

# Datasource pour récupérer les AZs disponibles
data "aws_availability_zones" "available" {
  state = "available"
}
