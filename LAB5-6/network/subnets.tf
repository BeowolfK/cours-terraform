# Subnet Privé - 192.168.7.0/24
resource "aws_subnet" "private" {
  vpc_id            = data.aws_vpc.lab56.id
  cidr_block        = "192.168.7.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "student_7_9_Private"
  }
}

# Subnet Public A - 192.168.9.0/24
resource "aws_subnet" "public_a" {
  vpc_id                  = data.aws_vpc.lab56.id
  cidr_block              = "192.168.9.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "student_7_9_Public_a"
  }
}

# Subnet Public B - 192.168.109.0/24
resource "aws_subnet" "public_b" {
  vpc_id                  = data.aws_vpc.lab56.id
  cidr_block              = "192.168.109.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "student_7_9_Public_b"
  }
}
