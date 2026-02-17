# Import de la clé publique SSH dans AWS
resource "aws_key_pair" "ec2_key" {
  key_name   = var.ssh_key_name
  public_key = file("${path.module}/${var.ssh_public_key_path}")
}

# Security Group pour autoriser SSH (port 22)
resource "aws_security_group" "allow_ssh" {
  name        = var.security_group_name
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.selected.id  # Récupéré via datasource

  # Règle entrante : autoriser SSH depuis les CIDR configurés
  ingress {
    description = "SSH from configured CIDR"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allow_ssh_from_cidr
  }

  # Règle sortante : autoriser tout le trafic sortant
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}

# Instance EC2
resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux.id  # AMI récupérée via datasource
  instance_type = var.instance_type              # Type configurable
  subnet_id     = data.aws_subnet.selected.id   # Subnet récupéré via datasource

  # Associer la clé SSH
  key_name = aws_key_pair.ec2_key.key_name

  # Associer le security group
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # Configuration du stockage
  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = var.instance_name
  }
}
