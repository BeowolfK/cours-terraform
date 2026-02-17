# Instances du module ASG pour Student Y (9)

# ASG pour Nginx - 2 replicas
module "nginx_asg" {
  source = "./modules/asg"

  name          = "student-7-9-nginx-asg"
  ami_id        = data.aws_ami.bitnami_nginx.id
  instance_type = "t3.micro"

  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  subnet_ids         = [data.aws_subnet.private.id]
  security_group_ids = [data.aws_security_group.internal.id]
  target_group_arns  = [data.aws_lb_target_group.nginx.arn]

  health_check_type          = "ELB"
  health_check_grace_period  = 300
}

# ASG pour Tomcat - 2 replicas
module "tomcat_asg" {
  source = "./modules/asg"

  name          = "student-7-9-tomcat-asg"
  ami_id        = data.aws_ami.bitnami_tomcat.id
  instance_type = "t3.micro"

  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  subnet_ids         = [data.aws_subnet.private.id]
  security_group_ids = [data.aws_security_group.internal.id]
  target_group_arns  = [data.aws_lb_target_group.tomcat.arn]

  health_check_type          = "ELB"
  health_check_grace_period  = 300
}
