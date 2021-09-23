
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


if (-not(Test-Path -Path Ubuntu.appx -PathType Leaf)) {
    try {
        Write-Host "Downloading distribution from https://aka.ms/wslubuntu2004."
        Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing
    }
    catch {
        throw $_.Exception.Message
    }
}
if (-not(Test-Path -Path lxr.zip -PathType Leaf)) {
    try {
        Write-Host "Downloading offline lxr from https://github.com/DDoSolitary/LxRunOffline/releases/download/v3.5.0/LxRunOffline-v3.5.0-msvc.zip."
        Invoke-WebRequest -Uri https://github.com/DDoSolitary/LxRunOffline/releases/download/v3.5.0/LxRunOffline-v3.5.0-msvc.zip -OutFile lxr.zip -UseBasicParsing
    }
    catch {
        throw $_.Exception.Message
    }
}

Copy-Item .\Ubuntu.appx .\$main.zip
Expand-Archive .\$main.zip -Force
Expand-Archive .\lxr.zip -Force -DestinationPath .
wsl.exe --import $main .\$main .\$main\install.tar.gz
wsl.exe -d $main NEWUSER=$user bash -c 'groupadd -g 1000 \$NEWUSER && useradd -m -r -u 1000 -g \$NEWUSER -d /home/\$NEWUSER -s /usr/bin/bash \$NEWUSER && echo \$NEWUSER:\$NEWUSER | chpasswd && echo \$NEWUSER ALL=\(ALL\) NOPASSWD:ALL >> /etc/sudoers'
.\lxr\LxRunOffline.exe su -n $main -v 1000


wsl.exe -d $main bash -c "`\
mkdir -p ~/.swlocal `\
&& cd ~/.swlocal `\
&& git clone https://github.com/jelical/ubuntu-wsl2-systemd-script.git `\
&& cd ubuntu-wsl2-systemd-script/ `\
&& bash ubuntu-wsl2-systemd-script.sh `\
&& wsl.exe --terminate $main"


