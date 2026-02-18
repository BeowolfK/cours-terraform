# Role IAM pour le bastion (permet de lire les parametres SSM)
resource "aws_iam_role" "bastion" {
  name = "student_7_9_bastion_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "student_7_9_bastion_role"
  }
}

# Politique IAM pour lire les parametres SSM /lab6/db/*
resource "aws_iam_role_policy" "bastion_ssm" {
  name = "student_7_9_bastion_ssm_policy"
  role = aws_iam_role.bastion.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = "arn:aws:ssm:eu-west-3:*:parameter/lab6/db/*"
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = "*"
      }
    ]
  })
}

# Instance profile pour attacher le role au bastion EC2
resource "aws_iam_instance_profile" "bastion" {
  name = "student_7_9_bastion_profile"
  role = aws_iam_role.bastion.name
}
