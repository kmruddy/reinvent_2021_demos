variable "prefix" {
  type    = string
  default = "ruddy"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "ubuntu-web" {
  ami_name      = "${var.prefix}-ubuntu-web-${local.timestamp}"
  ami_regions   = ["${var.region}"]
  instance_type = "t2.micro"
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  hcp_packer_registry {
    bucket_name = "ubuntu-web-aws"
    description = <<EOT
This is an Ubuntu-based build that has been prepared as a web server in AWS.
    EOT

    labels = {
      "build-version" = "0.1.0",
      "service"       = "aws",
    }
  }

  sources = ["source.amazon-ebs.ubuntu-web"]

  provisioner "file" {
    source      = "certs/tf-packer.pub"
    destination = "/tmp/tf-packer.pub"
  }
  provisioner "shell" {
    script = "scripts/setup.sh"
  }
}
