#locals {
#  vpc_cidr = "172.31.0.0/16"
#}
#
#locals {
#  security_groups = {
#    public = {
#      name        = "public_sg"
#      description = "Security group for Public Access"
#      ingress = {
#        ssh = {
#          from        = 22
#          to          = 22
#          protocol    = "tcp"
#          cidr_blocks = [var.access_ip]
#        }
#        http = {
#          from        = 80
#          to          = 80
#          protocol    = "tcp"
#          cidr_blocks = [var.access_ip]
#        }
#        https = {
#          from        = 443
#          to          = 443
#          protocol    = "tcp"
#          cidr_blocks = [var.access_ip]
#        }
#      }
#    }
#  }
#}

locals {
  tags= {
    env="dev"
    project = "aws-vpc"
  }
}
