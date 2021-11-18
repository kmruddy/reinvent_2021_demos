locals {
  private_key = file("./tf-packer")
  public_key  = file("./tf-packer.pub")
}

variable "hashi_products" {
  type = map(string)
  default = {
    "Vagrant"   = "https://www.datocms-assets.com/2885/1620155118-brandhcvagrantprimaryattributedcolor.svg"
    "Packer"    = "https://www.datocms-assets.com/2885/1620155103-brandhcpackerprimaryattributedcolor.svg"
    "Terraform" = "https://www.datocms-assets.com/2885/1620155113-brandhcterraformprimaryattributedcolor.svg"
    "Vault"     = "https://www.datocms-assets.com/2885/1620159869-brandvaultprimaryattributedcolor.svg"
    "Nomad"     = "https://www.datocms-assets.com/2885/1620155098-brandhcnomadprimaryattributedcolor.svg"
    "Consul"    = "https://www.datocms-assets.com/2885/1620155090-brandhcconsulprimaryattributedcolor.svg"
    "Waypoint"  = "https://www.datocms-assets.com/2885/1620155130-brandhcwaypointprimaryattributedcolor.svg"
    "Boundary"  = "https://www.datocms-assets.com/2885/1620155080-brandhcboundaryprimaryattributedcolor.svg"
  }
}

variable "public_ip" {
  description = "Public IP of the associated web application"
}
