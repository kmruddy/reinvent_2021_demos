#!/bin/bash
set -x

# Install necessary dependencies
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sleep 10
sudo apt-get update
sudo apt-get -y -qq install curl wget git apache2
sleep 10
sudo systemctl enable apache2
sudo chown -R ubuntu:ubuntu /var/www/html

# Configure local director and SSH keys
sudo mkdir -p /home/ubuntu/.ssh
sudo chmod 700 /home/ubuntu/.ssh
sudo cp /tmp/tf-packer.pub /home/ubuntu/.ssh/authorized_keys
sudo chmod 600 /home/ubuntu/.ssh/authorized_keys
sudo chown -R terraform /home/ubuntu/.ssh
sudo usermod --shell /bin/bash ubuntu
