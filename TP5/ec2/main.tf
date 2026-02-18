# ASG Nginx : déploie 2 à 4 instances nginx dans le subnet privé
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

  health_check_type         = "ELB"
  health_check_grace_period = 300

  user_data = <<-EOF
    #!/bin/bash
    sudo mkdir -p /opt/bitnami/nginx/html/nginx
    echo "<html><body><h1>Nginx Server - LAB5-6</h1><p>Student 7 & 9</p><p>Instance: $(hostname)</p></body></html>" | sudo tee /opt/bitnami/nginx/html/nginx/index.html
  EOF
}

# ASG Tomcat : déploie 2 à 4 instances tomcat dans le subnet privé
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

  health_check_type         = "ELB"
  health_check_grace_period = 300

  user_data = <<-EOF
    #!/bin/bash
    sudo mkdir -p /opt/bitnami/tomcat/webapps/tomcat
    echo "<html><body><h1>Tomcat Server - LAB5-6</h1><p>Student 7 & 9</p><p>Instance: $(hostname)</p></body></html>" | sudo tee /opt/bitnami/tomcat/webapps/tomcat/index.html
  EOF
}
