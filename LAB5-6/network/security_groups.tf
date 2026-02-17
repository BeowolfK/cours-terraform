# Security group public : autorise HTTP/HTTPS depuis Internet (attaché à l'ALB)
resource "aws_security_group" "public" {
  name        = "student_7_9_public"
  description = "Allow HTTP and HTTPS from internet"
  vpc_id      = data.aws_vpc.lab56.id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

# Security group internal : autorise le trafic uniquement depuis le SG public (attaché aux instances)
resource "aws_security_group" "internal" {
  name        = "student_7_9_internal"
  description = "Allow HTTP and HTTPS from public security group only"
  vpc_id      = data.aws_vpc.lab56.id

  ingress {
    description     = "HTTP from public SG"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  ingress {
    description     = "HTTPS from public SG"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  ingress {
    description     = "Tomcat from public SG"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

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
