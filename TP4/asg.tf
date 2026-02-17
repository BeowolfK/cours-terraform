# Launch Template pour l'Auto Scaling Group
resource "aws_launch_template" "app" {
  name_prefix   = "${var.instance_name}-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ec2_key.key_name

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.volume_size
      volume_type = "gp3"
      encrypted   = true
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.instance_name
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app" {
  name                = "${var.instance_name}-asg"
  vpc_zone_identifier = [data.aws_subnet.selected.id]
  target_group_arns   = []
  health_check_type   = "EC2"
  health_check_grace_period = 300

  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_min_size

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.instance_name}-asg-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = terraform.workspace
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
