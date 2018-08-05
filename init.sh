#!/bin/bash
# This block defines the variables the user of the script needs to input
# when deploying using this script.
#
# Set sudo user name
#<UDF name="username" label="The user's name for the new Linode.">
#USERNAME=
#
#<UDF name="hostname" label="The hostname for the new Linode.">
#HOSTNAME=
#
#<UDF name="fqdn" label="The new Linode's Fully Qualified Domain Name">
#FQDN=

# This sets the variable $IPADDR to the IP address the new Linode receives.
IPADDR=$(/sbin/ifconfig eth0 | awk '/inet / { print $2 }' | sed 's/addr://')

# Stop ssh while install
systemctl stop ssh.service

# This updates the packages on the system from the distribution repositories.
apt update
apt upgrade -y

# This section sets the hostname.
echo $HOSTNAME > /etc/hostname
hostname -F /etc/hostname

# This section sets the Fully Qualified Domain Name (FQDN) in the hosts file.
echo $IPADDR $FQDN $HOSTNAME >> /etc/hosts

# Add sudo user
adduser --disabled-password --gecos "" $USERNAME
usermod -aG sudo $USERNAME

# Install Vim-Bootstrap
apt install -y git exuberant-ctags ncurses-term curl vim
sudo -u $USERNAME -H sh -c "/usr/bin/curl 'http://vim-bootstrap.com/generate.vim' --data 'langs=javascript&langs=php&langs=html&langs=ruby&langs=go&langs=c&langs=python&langs=elm&langs=&editor=vim' > ~/.vimrc"
sudo -u $USERNAME -H sh -c "echo -ne '\n' | vim +PlugInstall +qall"

# Python virtualenvwrapper
apt install -y python3-pip
sudo -u $USERNAME -H sh -c "/usr/bin/pip3 install -U pip"
ln -s /usr/bin/python3 /usr/bin/python
sudo -u $USERNAME -H sh -c "export PATH=/home/$USERNAME/.local/bin:$PATH && pip install --user virtualenvwrapper"
sudo -u $USERNAME -H sh -c "echo export WORKON_HOME=/home/$USERNAME/.virtualenvs"
export PROJECT_HOME=/home/$USERNAME/Devel
source /home/$USERNAME/.local/bin/virtualenvwrapper.sh' >> ~/.bashrc"

reboot
