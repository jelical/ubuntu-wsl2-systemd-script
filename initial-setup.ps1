wsl.exe --set-default-version 2

$main = Read-Host "Enter you distro name:(main2)"
if ([string]::IsNullOrWhiteSpace($main))
{
  $main="main2"
}

$user = Read-Host "Enter you desired user:($env:username)"
if ([string]::IsNullOrWhiteSpace($user))
{
  $user=$env:username
}


if (-not(Test-Path -Path root.tar.gz -PathType Leaf)) {
    try {
        Write-Host "Downloading ubuntu 20.04.4 basic distribution ."
        Invoke-WebRequest -Uri http://github.com/jelical/ubuntu-wsl2-systemd-script/releases/download/2.0/root.tar.gz -OutFile root.tar.gz -UseBasicParsing
    }
    catch {
        throw $_.Exception.Message
    }
}
if (-not(Test-Path -Path LxRunOffline.exe -PathType Leaf)) {
    try {
        Write-Host "Downloading offline lxr"
        Invoke-WebRequest -Uri  http://github.com/jelical/ubuntu-wsl2-systemd-script/releases/download/2.0/LxRunOffline.exe -OutFile LxRunOffline.exe -UseBasicParsing
    }
    catch {
        throw $_.Exception.Message
    }
}

Write-Host "Unpacking root fs..."
wsl.exe --import $main .\$main .\root.tar.gz

Write-Host "Setting up vital services..."
wsl.exe -d $main bash -c 'apt-get update -y;apt-get upgrade -y;hwclock -s;apt-get install -yqq sudo wget curl vim systemd snapd fuse keychain slim daemonize dbus-user-session fontconfig ca-certificates gnupg lsb-release'

Write-Host "Setting up docker..."
wsl.exe -d $main bash -c 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg; `\
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null; `\
apt-get update && apt-get install -yqq docker-ce docker-ce-cli containerd.io'

Write-Host "Setting up msedge"
wsl.exe -d $main bash -c 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg; `\
install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/; `\
echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list; `\
rm microsoft.gpg; `\
apt update && apt install microsoft-edge-stable'

Write-Host "Setting up google chrome..."
wsl.exe -d $main bash -c 'wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i google-chrome-stable_current_amd64.deb'

Write-Host "Setting up  default user..."
wsl.exe -d $main NEWUSER=$user bash -c 'groupadd -g 1000 \$NEWUSER && `\
useradd -m -r -u 1000 -g \$NEWUSER -d /home/\$NEWUSER -s /usr/bin/bash \$NEWUSER && `\
echo \$NEWUSER:\$NEWUSER | chpasswd && echo \$NEWUSER ALL=\(ALL\) NOPASSWD:ALL >> /etc/sudoers; `\
usermod -aG docker \$NEWUSER'
.\LxRunOffline.exe su -n $main -v 1000

Write-Host "Setting up systemd ..."
wsl.exe -d $main bash -c "`\
mkdir -p ~/.swlocal `\
&& cd ~/.swlocal `\
&& git clone https://github.com/jelical/ubuntu-wsl2-systemd-script.git `\
&& cd ubuntu-wsl2-systemd-script/ `\
&& bash ubuntu-wsl2-systemd-script.sh `\
&& wsl.exe --terminate $main"
