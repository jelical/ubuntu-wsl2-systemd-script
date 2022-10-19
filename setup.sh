#!/bin/bash

echo "Apt get vital stuff..."
sudo apt-get update -y
sudo apt-get upgrade -y
sudo hwclock -s
sudo apt-get install -yqq wget curl vim keychain slim fontconfig ca-certificates gnupg lsb-release ntpdate
sudo ntpdate -s time.nist.gov

echo "Sudoers..."
sudo bash -c "echo $USER ALL=\(ALL\) NOPASSWD:ALL >> /etc/sudoers"

echo "Docker..."
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo bash -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null'
sudo apt-get update 
sudo apt-get install -yqq docker-ce docker-ce-cli containerd.io

echo "adding user to docker group..."
sudo usermod -aG docker $USER

echo "patching docker daemon setup"
sudo tee -a /etc/systemd/system/docker.service.d/override.conf > /dev/null <<EOT
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --containerd=/run/containerd/containerd.sock
EOT

echo "setup dotnet"
sudo apt-get update && sudo apt-get install -y dotnet-sdk-6.0

echo "setup node"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
nvm install 16.13.1
nvm alias default 16.13.1
npm install -g yarn

echo "edge and chrome"
sudo bash -c 'curl https://packages.microsoft.com/keys/microsoft.asc | bash -c "gpg --dearmor > microsoft.gpg"'
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo bash -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm microsoft.gpg
sudo apt-get update -yy && sudo apt-get install microsoft-edge-stable -yy
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo rm google-chrome-stable_current_amd64.deb


echo "xwin"
echo "export DISPLAY="$(awk '/nameserver/ { print $2 }' < /etc/resolv.conf)":0" >> ~/.bashrc 
echo "systemctl --user import-environment WSL_INTEROP" >> ~/.bashrc 
rm -rf ~/.xwin
mkdir -p ~/.xwin
curl -L http://github.com/jelical/ubuntu-wsl2-systemd-script/releases/download/2.0/xwin.tar.gz | tar -C ~/.xwin -zxf -
mkdir -p ~/.local/share/systemd/user
rm -f ~/.local/share/systemd/user/xwin2.service
curl -L https://raw.githubusercontent.com/jelical/ubuntu-wsl2-systemd-script/master/xwin2.service > ~/.local/share/systemd/user/xwin2.service
sudo loginctl enable-linger $USER
systemctl --user daemon-reload
systemctl --user enable xwin2
systemctl --user restart xwin2
systemctl --user status xwin2

echo "aliases"
curl -L https://raw.githubusercontent.com/jelical/ubuntu-wsl2-systemd-script/master/.bash_aliases > ~/.bash_aliases

echo "snaps"
sudo snap install rider --classic
sudo snap install webstorm --classic
sudo snap install datagrip --classic

echo "done"



