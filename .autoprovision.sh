#!/bin/sh

if [ -d ~/Development/ansible-pop_os/ ]; 
then
    echo "Playbook is already local. Cannot safely autoprovision. Delete ~/Development/ansible-pop_os and rerun, or manually run the playbook to continue.";
    exit 1;
fi

# Update Packages
sudo apt update && sudo NEEDRESTART_MODE=a apt-get -y upgrade
sudo apt install -y ansible git

# Make Development Folder and Clone the Repo
mkdir -p ~/Development;
git clone https://github.com/carefreecaribou/ansible-pop_os ~/Development/ansible-pop_os;
[ -f ~/provision-config.yml ] && mv ~/provision-config.yml ~/Development/ansible-pop_os/config.yml;
cd ~/Development/ansible-pop_os

# Run the Playbook
ansible-galaxy install -r requirements.yml
clear && ansible-playbook main.yml --ask-become-pass

