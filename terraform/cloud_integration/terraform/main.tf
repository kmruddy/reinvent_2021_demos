terraform {
  # Terraform cloud integration, requires Terraform 1.1+
  cloud {
    organization = "reInvent-Demo-Org"
    workspaces {
      tags = ["conference:reinvent", "service:aws", "service:hcp", "hashiapp"]
    }
  }

  required_version = ">=1.1.0"

  # Required provider block
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
  # HCP Packer authentication 
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}

module "packer_ami" {
  # Module sourced from the Terraform Cloud Private Registry
  source  = "app.terraform.io/reInvent-Demo-Org/packer_ami/hcp"
  version = "2.14.0"

  hcp_bucket  = var.hcp_bucket
  hcp_channel = var.hcp_channel
}

module "deploy_hashiapp" {
  # Module sourced from the Terraform Cloud Private Registry
  source  = "app.terraform.io/reInvent-Demo-Org/deploy_hashiapp/aws"
  version = "0.1.0"

  region = var.region
  prefix = var.prefix
  ami_id = module.packer_ami.ami_id
}
