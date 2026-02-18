# Security group pour l'instance RDS PostgreSQL
resource "aws_security_group" "rds" {
  name        = "student_7_9_rds"
  description = "Allow PostgreSQL access from bastion host"
  vpc_id      = data.aws_vpc.lab56.id

  # Regle d'egress : tout le trafic sortant autorise
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "student_7_9_rds"
  }
}

# Regle d'ingress ajoutee uniquement quand le bastion SG ID est fourni (Step 3)
resource "aws_security_group_rule" "rds_from_bastion" {
  count = var.bastion_sg_id != "" ? 1 : 0

  type                     = "ingress"
  description              = "PostgreSQL from bastion SG"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = var.bastion_sg_id
  security_group_id        = aws_security_group.rds.id
}
