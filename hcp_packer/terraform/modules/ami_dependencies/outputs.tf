output "subnet_id" {
  value = aws_subnet.hashiapp.id
}

output "sg_id" {
  value = aws_security_group.hashiapp.id
}

output "public_ip" {
  value = aws_eip.hashiapp.public_ip
}

output "public_dns" {
  value = aws_eip.hashiapp.public_dns
}
