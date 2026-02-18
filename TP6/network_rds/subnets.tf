# Subnet prive A pour RDS dans la premiere zone de disponibilite
resource "aws_subnet" "private_a" {
  vpc_id                  = data.aws_vpc.lab56.id
  cidr_block              = "192.168.7.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "student_7_9_Private_a"
  }
}

# Subnet prive B pour RDS dans la deuxieme zone de disponibilite
# RDS necessite des subnets dans au moins 2 AZ differentes
resource "aws_subnet" "private_b" {
  vpc_id                  = data.aws_vpc.lab56.id
  cidr_block              = "192.168.107.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "student_7_9_Private_b"
  }
}
