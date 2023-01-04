#!/bin/bash

groupadd -g 1000 $1 
useradd -m -r -u 1000 -g $1 -d /home/$1 -s /bin/bash $1
echo $1:$1 | chpasswd
echo "$1 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

sudo tee -a /etc/wsl.conf > /dev/null <<EOT
[boot]
systemd=true
[user]
default=$1
EOT

