resource "aws_instance" "ec2_instance1" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id

  key_name = var.key_name

  user_data = file("${path.module}/user_data_instance1.sh")

  security_groups = var.security_group_ids

  tags = {
    Name = "${var.project_name}-instance1"
  }
}

resource "aws_instance" "ec2_instance2" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id

  key_name = var.key_name

  user_data = file("${path.module}/user_data_instance2.sh")

  security_groups = var.security_group_ids

  tags = {
    Name = "${var.project_name}-instance2"
  }
}


# Elastic Ip Creation and Association

resource "aws_eip" "eip1" {
  instance = aws_instance.ec2_instance1.public_ip
  domain = "vpc"
}

resource "aws_eip" "eip2" {
  instance = aws_instance.ec2_instance2.public_ip
  domain ="vpc"
}

resource "aws_lb_target_group_attachment" "instance1_attachment" {
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.ec2_instance1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "instance2_attachment" {
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.ec2_instance2.id
  port             = 80
}