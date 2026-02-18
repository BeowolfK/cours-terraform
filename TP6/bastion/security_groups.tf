# Security group pour le bastion host
resource "aws_security_group" "bastion" {
  name        = "student_7_9_bastion"
  description = "Allow SSH access to bastion host"
  vpc_id      = data.aws_vpc.lab56.id

  # SSH depuis votre IP
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # Tout le trafic sortant autorise
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "student_7_9_bastion"
  }
}
