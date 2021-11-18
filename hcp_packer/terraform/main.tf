terraform {
  cloud {
    organization = "TPMM-Org"
    workspaces {
      tags = ["conference:reinvent", "service:aws", "service:hcp", "hashiapp"]
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=3.42.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.20.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}

data "hcp_packer_iteration" "hashiapp_iteration" {
  bucket_name = var.hcp_bucket
  channel     = var.hcp_channel
}

data "hcp_packer_image" "hashiapp_image" {
  bucket_name    = var.hcp_bucket
  cloud_provider = var.hcp_provider
  iteration_id   = data.hcp_packer_iteration.hashiapp_iteration.ulid
  region         = var.region
}

module "ami_dependencies" {
  region = var.region
  prefix = var.prefix
}


resource "aws_instance" "hashiapp" {
  ami                         = data.hcp_packer_image.hashiapp_image.cloud_image_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = module.ami_dependencies.subnet_id
  vpc_security_group_ids      = [module.ami_dependencies.sg_id]

  tags = {
    Name = "${var.prefix}-hashiapp-instance"
  }
}

module "ami_post_actions" {
  public_ip = module.ami_dependencies.public_ip
}
