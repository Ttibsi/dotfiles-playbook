#!/bin/bash

SSH_DIR="$HOME/.ssh"

# Check out correct branch
if ! [ -z $1 ]; then
    echo ----- Checking out $1 -----
    git checkout -b $1 origin/$1
fi

sudo dpkg --configure --pending
sudo apt-get update 
sudo apt-get upgrade -y

echo -e "\nShow Percentage in top bar"
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Check if ansible is installed
if ! [ -x "$(command -v ansible)" ]; then
    echo -e  "\n----- Installing ansible -----"
    sudo apt install ansible -y
fi

# Check if Cowsay is installed
if [ -x "$(command -v cowsay)" ]; then
    echo -e "\n----- Removing cowsay -----"
    sudo apt remove cowsay -y
fi

# Generate SSH keys
if ! [[ -f "$SSH_DIR/authorized_keys" ]]; then
    echo -e "\n----- Generating SSH key -----"
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -C "$USER@$HOSTNAME"
    cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"
fi

# Install ansible requirements
echo -e "\n----- Installing requirements -----"
ansible-galaxy install -r requirements.yml

ansible-playbook -K main.yml

rm -rf $HOME/.ansible

echo -e "\n------Mounting NAS------"
sudo apt install nfs-common
echo "192.168.0.24:/export/PiShare /mnt/PiShare nfs defaults 0 0" | sudo tee /etc/fstab -a

sudo apt autoclean -y
sudo apt autoremove -y

echo -e "\n\nCopying SHH pub key to clipboard"
cat "$SSH_DIR/id_rsa.pub" | xclip -selection c
echo Add to account here: https://github.com/settings/keys

echo -e "\n---------------\n"

echo -e "Provisioning complete"
echo -e "Reboot the system now"
