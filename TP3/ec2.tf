# Import de la clé publique SSH dans AWS
resource "aws_key_pair" "ec2_key" {
  key_name   = "terraform-ec2-key"
  public_key = file("${path.module}/aws-ec2-key.pub")
}

# Security Group pour autoriser SSH (port 22)
resource "aws_security_group" "allow_ssh" {
  name        = "terraform-allow-ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-083052666da04fb53"

  # Règle entrante : autoriser SSH depuis n'importe où
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Attention : en production, restreindre à votre IP
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
    Name = "terraform-allow-ssh"
  }
}

# Instance EC2
resource "aws_instance" "main" {
  ami           = "ami-092c64119783c2f31"
  instance_type = "t3.micro"
  subnet_id     = "subnet-0d2b7f8e860ab5e38"

  # Associer la clé SSH
  key_name = aws_key_pair.ec2_key.key_name

  # Associer le security group
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # Configuration du stockage
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "terraform-ec2-instance-kenan"
  }
}
