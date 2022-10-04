## Terraform configuration
#
#provider "aws" {
#  region = "us-east-1"
#}
#
#module "vpc" {
#  source  = "SRK_RAJU/terraform-aws-modules/vpc/aws"
#  version = "2.21.0"
#
#  name = var.vpc_name
#  cidr = var.vpc_cidr
#
#  azs             = var.vpc_azs
#  private_subnets = var.vpc_private_subnets
#  public_subnets  = var.vpc_public_subnets
#
#  enable_nat_gateway = var.vpc_enable_nat_gateway
#
#  tags = var.vpc_tags
#}
#
#module "ec2_instances" {
#  source  = "terraform-aws-modules/ec2-instance/aws"
#  version = "2.12.0"
#
#  name           = "my-ec2-cluster"
#  instance_count = 2
#
#  ami                    = "ami-0c5204531f799e0c6"
#  instance_type          = "t2.micro"
#  vpc_security_group_ids = [module.vpc.default_security_group_id]
#  subnet_id              = module.vpc.public_subnets[0]
#
#  tags = {
#    Terraform   = "true"
#    Environment = "dev"
#  }
#}
#
#module "website_s3_bucket" {
#  source = "./modules/aws-s3-static-website-bucket"
#
#  bucket_name = "bogo-test-april-19-2021"
#
#  tags = {
#    Terraform   = "true"
#    Environment = "dev"
#  }
#}

module "network" {
  source          = "./vpc"
  access_ip       = var.access_ip
  vpc_cidr        = local.vpc_cidr
  security_groups = local.security_groups
}
module "ec2" {
  source        = "./ec2"
  public_sg     = module.network.public_sg
  public_subnet = module.network.public_subnet
}