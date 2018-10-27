#!/bin/bash

# Denne filen inneholder alt software vi trenger til kurs
# Java
# Google Chrome
# Git, npm
# 

result=`which java`

if ! [[ -z "$result" ]]; then
    exit;
fi

# Tell Ubuntu to not use ncurses to prompt for user input
export DEBIAN_FRONTEND=noninteractive

# Enable Ubuntu Multiverse repo to get to VirtualBox Guest Additions debs
sed -i '/^#.* bionic multiverse/s/^#//' /etc/apt/sources.list
sed -i '/^#.* bionic-updates multiverse/s/^#//' /etc/apt/sources.list

# Add PPA that has the Oracle 8 SDK packages in it for Ubuntu
echo -e "\n**** Installing Repository for Oracle JAVA Installers ****\n"
apt-get -qq -y install software-properties-common 2> /dev/null
add-apt-repository -y ppa:webupd8team/java 2> /dev/null

# Update available packages
apt-get update > /dev/null

# Install Oracle Java 8 SDK
echo -e "\n**** Installing Oracle JAVA 8. This might take a while... ****\n"
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -qq -y install oracle-java8-installer 2> /dev/null
apt-get -qq -y install oracle-java8-set-default 2> /dev/null

# Add JAVA_HOME to environment
cat <<EOL >> /etc/environment
JAVA_HOME=/usr/lib/jvm/java-8-oracle
EOL

# Install Google Chrome
echo -e "\n**** Installing Google Chrome"
sh -c "echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/chrome.list"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
apt-get update
apt-get install -y google-chrome-stable
sed -i 's/google\-chrome\-stable/google\-chrome\-stable \-\-disable-gpu/g' /usr/share/applications/google-chrome.desktop

echo -e "\n**** Installing build-essentials, Git and npm (might take several minutes ...)"
# Install lightdm, build-essential, git, npm and unity-tweak-tool
apt-get -qq -y install lightdm build-essential git-core git npm unity-tweak-tool >/dev/null

echo -e "\n**** Installing Node version manager 'n' and use it to install the latest Node"
# Install the Node version manager n, and use it to install the latest Node since the repository version
# is usually outdated...
npm install -g n > /dev/null
n latest > /dev/null


# Set up LightDM to autologin vagrant in an i3 session
echo -e "\n**** Setting Vagrant to autologin"
cat > /etc/lightdm/lightdm.conf <<EOF
[SeatDefaults]
autologin-user=vagrant
autologin-user-timeout=0
user-session=ubuntu-2d
greeter-session=unity-greeter
EOF

echo -e "\n**** A bit of cleanup and we are soon finished ..."
sudo invoke-rc.d apparmor stop
sudo update-rc.d -f apparmor remove

apt-get -y -f purge thunderbird libreoffice empathy ubuntu-docs gnome-user-guide deja-dup remmina transmission brasero cheese totem

