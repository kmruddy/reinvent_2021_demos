# Outputs file
output "hashiapp_url" {
  value = "http://${module.ami_dependencies.public_dns}"
}

output "hashiapp_ip" {
  value = "http://${module.ami_dependencies.public_ip}"
}


