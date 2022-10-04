resource "aws_vpc" "my_vpc" {
  cidr_block = "172.31.0.0/26"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "my-vpc"
  }
}
#resource "aws_security_group" "alb" {
#  name        = "tf_alb_sg"
#  description = "Terraform load balancer security group"
#  vpc_id      = aws_vpc.my_vpc.id
#
#  ingress {
#    from_port   = 443
#    to_port     = 443
#    protocol    = "tcp"
#    cidr_blocks = ["172.0.0.0/26"]
#  }
#
#  ingress {
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["172.0.0.0/26"]
#  }
#
#  # Allow all outbound traffic.
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  tags = {
#    Name = "alb-sg"
#  }
#}
#
#resource "aws_alb" "alb" {
#  name            = "terraform-alb"
#  security_groups = [aws_security_group.alb.id]
#  subnets         = [aws_subnet.public-sub.id,aws_subnet.private-sub.id]
#  tags = {
#    Name = "terraform-alb"
#  }
#}
#
#
#
#resource "aws_lb" "nlb" {
#  name               = "nlb-lb-tf"
#  internal           = false
#  load_balancer_type = "network"
#  #  security_groups = [aws_security_group.allow-sg-pvt.id]
#  subnets            = [aws_subnet.public-sub.id,aws_subnet.private-sub.id]
#
#  enable_deletion_protection = false
#
#
#  tags = {
#    Name="NLB-terraform"
#    Environment = "production"
#  }
#}
##### aws alb target group
#resource "aws_alb_target_group" "group" {
#  name     = "tf-alb-target"
#  port     = 80
#  protocol = "HTTP"
#  vpc_id   = "${aws_vpc.my_vpc.id}"
#  stickiness {
#    type = "lb_cookie"
#  }
#  # Alter the destination of the health check to be the login page.
#  health_check {
#    path = "/login"
#    port = 80
#  }
#}
#### alb target group http listener
#resource "aws_alb_listener" "listener_http" {
#  load_balancer_arn = "${aws_alb.alb.arn}"
#  port              = "80"
#  protocol          = "HTTP"
#
#  default_action {
#    target_group_arn = "${aws_alb_target_group.group.arn}"
#    type             = "forward"
#  }
#}