# Groupe de subnets pour RDS (necessite au moins 2 AZ)
resource "aws_db_subnet_group" "lab6" {
  name       = "student-7-9-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "student_7_9_db_subnet_group"
  }
}

# Instance RDS PostgreSQL
resource "aws_db_instance" "lab6" {
  identifier     = "student-7-9-lab6-db"
  engine         = "postgres"
  engine_version = "14"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "labdb"
  username = "labadmin"
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.lab6.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  # Pas d'acces public (subnets prives uniquement)
  publicly_accessible = false

  # Desactiver le snapshot final pour faciliter la suppression en lab
  skip_final_snapshot = true

  tags = {
    Name = "student_7_9_lab6_db"
  }
}
