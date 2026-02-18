# Cle SSH pour le bastion
resource "aws_key_pair" "bastion" {
  key_name   = var.key_name
  public_key = file("~/.ssh/student_7_9_key.pub")
}

# Instance EC2 bastion host
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_bastion.id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  key_name               = aws_key_pair.bastion.key_name
  iam_instance_profile   = aws_iam_instance_profile.bastion.name

  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -e

    # Mise a jour du systeme
    yum update -y

    # Installation du client PostgreSQL 14
    amazon-linux-extras install postgresql14 -y

    # Creation du script de connexion a la base de donnees
    cat > /home/ec2-user/connect-db.sh << 'SCRIPT'
    #!/bin/bash
    # Script de connexion a la base de donnees RDS
    # Recupere les credentials depuis SSM Parameter Store

    REGION="eu-west-3"

    echo "Recuperation des credentials depuis SSM..."
    DB_ENDPOINT=$(aws ssm get-parameter --name "/lab6/db/endpoint" --region $REGION --query "Parameter.Value" --output text)
    DB_USERNAME=$(aws ssm get-parameter --name "/lab6/db/username" --region $REGION --query "Parameter.Value" --output text)
    DB_PASSWORD=$(aws ssm get-parameter --name "/lab6/db/password" --region $REGION --with-decryption --query "Parameter.Value" --output text)
    DB_NAME=$(aws ssm get-parameter --name "/lab6/db/name" --region $REGION --query "Parameter.Value" --output text)

    # Extraction du host et du port depuis l'endpoint (format: host:port)
    DB_HOST=$(echo $DB_ENDPOINT | cut -d: -f1)
    DB_PORT=$(echo $DB_ENDPOINT | cut -d: -f2)

    echo "Connexion a $DB_HOST:$DB_PORT/$DB_NAME en tant que $DB_USERNAME..."
    PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USERNAME -d $DB_NAME
    SCRIPT

    chmod +x /home/ec2-user/connect-db.sh
    chown ec2-user:ec2-user /home/ec2-user/connect-db.sh

    echo "Setup complete. Utilisez /home/ec2-user/connect-db.sh pour se connecter a la DB."
  EOF

  tags = {
    Name = "student_7_9_bastion"
  }
}
