# Subnet privé pour les instances EC2 (sans IP publique)
resource "aws_subnet" "private" {
  vpc_id                  = data.aws_vpc.lab56.id
  cidr_block              = "192.168.7.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "student_7_9_Private"
  }
}

# Subnet public A pour l'ALB dans la première zone de disponibilité
resource "aws_subnet" "public_a" {
  vpc_id                  = data.aws_vpc.lab56.id
  cidr_block              = "192.168.9.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "student_7_9_Public_a"
  }
}

# Subnet public B pour l'ALB dans la deuxième zone de disponibilité
resource "aws_subnet" "public_b" {
  vpc_id                  = data.aws_vpc.lab56.id
  cidr_block              = "192.168.109.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "student_7_9_Public_b"
  }
}
