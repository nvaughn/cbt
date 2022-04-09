
terraform {

  cloud {
    organization = "nvaughn"
    workspaces {
      name = "Nashville"
    }
  }

  # Lock in our version to 3.x
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

###########################
# Virtual Private Cloud 
###########################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Class: ${var.class_name}.vpc"
  cidr = var.vpc_cidr_block

  azs            = [var.subnet_zone]
  public_subnets = [var.web_subnet]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

###########################
# Security groups 
###########################

#######
# HTTP
#######

module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

#######
# SSH
#######

module "ssh_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "ssh-server"
  description = "Security group for ssh-server with SSH ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

# Get latest x86_64 Amazon Linux2 AMI

data "aws_ami" "latest_amazon_linux2" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*x86_64-gp2"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

#Import existing SSH Key

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file(var.public_key)
  count      = var.create_key_pair ? 0 : 1

}

###########################
# EC2 Instance 
###########################

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  ami                    = data.aws_ami.latest_amazon_linux2.id
  name                   = "${var.class_name}-Instance#${count.index}"
  instance_type          = var.server_type
  key_name               = var.key_name
  vpc_security_group_ids = [module.ssh_server_sg.security_group_id, module.web_server_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = <<EOF
  #!/bin/bash

    sudo yum -y update && sudo yum -y install httpd
    sudo systemctl start httpd && sudo systemctl enable httpd
    sudo echo "<h1>Classroom Host Provisioning Complete</h1>" >/var/www/html/index.html
    sudo echo "<h2>Provisioned via TerraForm</h2>" >/var/www/html/index.html
    sudo yum install mailx -y
    sudo echo "Host Complete" | mail -s "Classroom Provisioning Complete" root@localhost
    
    EOF

  count = var.instance_count

  tags = {
    Terraform   = "true"
    Environment = "PROD"
  }
}


#####################
# S3 Bucket
#####################

module "website_s3_bucket" {
  source = "git@github.com:nvaughn/website_s3_bucket"

  bucket_name = "cbt-demo-04-11-2022"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

