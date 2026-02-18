# Parametres SSM pour stocker les credentials de la base de donnees
# Le bastion les recuperera via son role IAM

resource "aws_ssm_parameter" "db_endpoint" {
  name      = "/lab6/db/endpoint"
  type      = "String"
  value     = aws_db_instance.lab6.endpoint
  overwrite = true

  tags = {
    Name = "student_7_9_db_endpoint"
  }
}

resource "aws_ssm_parameter" "db_username" {
  name      = "/lab6/db/username"
  type      = "String"
  value     = aws_db_instance.lab6.username
  overwrite = true

  tags = {
    Name = "student_7_9_db_username"
  }
}

resource "aws_ssm_parameter" "db_password" {
  name      = "/lab6/db/password"
  type      = "SecureString"
  value     = var.db_password
  overwrite = true

  tags = {
    Name = "student_7_9_db_password"
  }
}

resource "aws_ssm_parameter" "db_name" {
  name      = "/lab6/db/name"
  type      = "String"
  value     = aws_db_instance.lab6.db_name
  overwrite = true

  tags = {
    Name = "student_7_9_db_name"
  }
}
