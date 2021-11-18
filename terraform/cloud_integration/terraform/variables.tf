locals {
  private_key = file("./tf-packer")
  public_key  = file("./tf-packer.pub")
}

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  default     = "ruddy"
}

variable "region" {
  description = "The region where the resources are created."
  default     = "eu-central-1"
}

variable "hcp_client_id" {
  description = "The client secret used to authenticate to the HCP Packer service."
}

variable "hcp_client_secret" {
  description = "The client secret used to authenticate to the HCP Packer service."
}

variable "hcp_bucket" {
  description = "The bucket name which should be referenced from HCP Packer"
}

variable "hcp_channel" {
  description = "The channel name which should be referenced from HCP Packer"
}

variable "instance_type" {
  description = "Specifies the AWS instance type."
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Specifies the AMI ID to use for an image deployment"
}
