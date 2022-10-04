
  ## key pairs

  resource "tls_private_key" "dev_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
  }

  resource "aws_key_pair" "generated_key" {
    key_name   = var.generated_key_name
    public_key = tls_private_key.dev_key.public_key_openssh

    provisioner "local-exec" {    # Generate "terraform-key-pair.pem" in current directory
      command = <<-EOT
      echo '${tls_private_key.dev_key.private_key_pem}' > ./'${var.generated_key_name}'.pem
      chmod 400 ./'${var.generated_key_name}'.pem
    EOT
    }

  }
module "ec2" {
  source = "./"
# resource "aws_instance" "app_server-pub" {
    ami           = var.ami
    instance_type = var.ec2-type
    key_name = var.generated_key_name
    security_groups = [ aws_security_group.allow-sg-pub.id ]
    subnet_id = aws_subnet.public-sub.id
#    iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
     user_data = <<-EOF
#! /bin/bash
sudo yum update -y
echo "Install Docker engine"
sudo yum install -y docker
sudo sudo chkconfig docker on
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker pull nginx:latest
sudo docker run --name mynginx4 -p 60:80 -d nginx

EOF


    tags = merge(
      local.tags,
      {
        #    Name = "pub-ec2-${count.index}"
        Name="pub-ec2"
        name= "devops-raju"
      })
  }
  resource "aws_eip" "nat-eip" {
    vpc=true
    tags = {
      Name="EIP"
    }
  }



