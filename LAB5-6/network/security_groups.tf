# Security Group Public - HTTP/HTTPS depuis Internet
resource "aws_security_group" "public" {
  name        = "student_7_9_public"
  description = "Allow HTTP and HTTPS from internet"
  vpc_id      = data.aws_vpc.lab56.id

  # HTTP depuis Internet
  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS depuis Internet
  ingress {
    description = "HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tout le trafic sortant
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "student_7_9_public"
  }
}

# Security Group Internal - HTTP/HTTPS uniquement depuis le SG Public
resource "aws_security_group" "internal" {
  name        = "student_7_9_internal"
  description = "Allow HTTP and HTTPS from public security group only"
  vpc_id      = data.aws_vpc.lab56.id

  # HTTP depuis le SG Public
  ingress {
    description     = "HTTP from public SG"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  # HTTPS depuis le SG Public
  ingress {
    description     = "HTTPS from public SG"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  # Port 8080 pour Tomcat depuis le SG Public
  ingress {
    description     = "Tomcat from public SG"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  # Tout le trafic sortant
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "student_7_9_internal"
  }
}
