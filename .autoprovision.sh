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
mkdir -p ~/Development/ansible-pop_os2204;
git clone https://github.com/carefreecaribou/ansible-pop_os2204 ~/Development/ansible-pop_os2204;
[ -f ~/provision-config.yml ] && mv ~/provision-config.yml ~/Development/ansible-pop_os2204/config.yml;
cd ~/Development/ansible-pop_os2204

# Run the Playbook
ansible-galaxy install -r requirements.yml
echo "remove_autostart: true" > config.yml
echo 'gnome-terminal -- bash -c "cd ~/Development/ansible-pop_os2204 && ansible-playbook main.yml --ask-become-pass; bash"' >> ~/.profile
sudo systemctl disable pop-upgrade.service
sudo reboot now