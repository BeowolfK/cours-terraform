# Subnet public pour le bastion host
resource "aws_subnet" "public_bastion" {
  vpc_id                  = data.aws_vpc.lab56.id
  cidr_block              = "192.168.9.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "student_7_9_Public_bastion"
  }
}
