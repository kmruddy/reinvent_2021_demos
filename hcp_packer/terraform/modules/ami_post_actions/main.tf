resource "random_integer" "rand_int" {
  min = 1
  max = 8
}

resource "random_shuffle" "happ_name" {
  input        = ["Vagrant", "Packer", "Terraform", "Vault", "Nomad", "Consul", "Waypoint", "Boundary"]
  result_count = random_integer.rand_int.result
}

resource "null_resource" "configure-hashi-app" {
  triggers = {
    build_number = timestamp()
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = local.private_key
    host        = var.public_ip
    timeout     = "1m"
  }

  provisioner "file" {
    source      = "files/"
    destination = "/home/ubuntu/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x *.sh",
      "URL=${var.hashi_products[random_shuffle.happ_name.result[0]]} HAPP=${random_shuffle.happ_name.result[0]} FQDN=${var.public_ip} ./deploy_app.sh",
      "sudo service apache2 reload",
    ]
  }
}
