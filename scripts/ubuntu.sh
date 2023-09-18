#!/bin/bash

SSH_DIR="$HOME/.ssh"

# 1- Install default version of ubuntu
# 2- Switch to tty (CTRL+ALT+fn key)
# 3- clone this repo and run this script

function main {
    sudo dpkg --configure --pending
    sudo apt-get update 
    sudo apt-get upgrade -y

    # Check if ansible is installed
    if ! [ -x "$(command -v ansible)" ]; then
        echo -e  "\n----- Installing ansible -----"
        sudo apt install ansible -y
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

    ansible-playbook -K tasks/ubuntu_playbook.yml

    echo -e "\n----- Removing ansible requirements -----"
    rm -rf $HOME/.ansible

    echo -e "Configuring Gnome"
    gsettings set org.gnome.desktop.interface show-battery-percentage true
    gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<primary><Super>left']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<primary><Super>right']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super><shift>left']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super><shift>right']"
    gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

    xdotool key super+y # Enable pop tiling

    echo -e "Configuring Bash"
    rm ~/.bashrc ~/.bash_aliases
    ln -s ~/Workspace/dotfiles-playbook/templates/bash-shell/bashrc ~/.bashrc
    ln -s ~/Workspace/dotfiles-playbook/templates/bash-shell/bash_aliases ~/.bash_aliases
    sudo systemctl start libvirtd

    echo -e "Configuring Firefox"
    sudo mkdir /etc/firefox/policies
    sudo ln -s ~/workspace/dotfiles-playbook/templates/firefox/policies.json \
	    /etc/firefox/policies/policies.json


    echo -e "Access PiShare"
    echo "//192.168.1.4/PiShare /mnt/PiShare cifs vers=3.0,credentials=/mnt/pishare_creds,iocharset=utf8,file_mode=0777,dir_mode=0777,sec=ntlmssp 0 0" | sudo tee -a /etc/fstab


    echo -e "\n----- Cleaning up apt -----"
    sudo apt autoclean -y
    sudo apt autoremove -y
    rm -rf $HOME/go

    echo -e "\n----- Copying SHH pub key to clipboard -----"
    cat "$SSH_DIR/id_rsa.pub" | xclip -selection c
    echo Add to account here: https://github.com/settings/keys

    echo -e "\n---------------\n"

    echo -e "Provisioning complete"
    echo -e "Reboot the system now"
}

time main
