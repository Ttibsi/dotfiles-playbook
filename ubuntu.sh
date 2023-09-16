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

    ansible-playbook -K ubuntu_playbook.yml

    echo -e "\n----- Removing ansible requirements -----"
    rm -rf $HOME/.ansible

    echo -e "Configuring Gnome"
    gsettings set org.gnome.desktop.interface show-battery-percentage true
    gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Alt>Left']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Alt>Right']"
    gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

    echo -e "Configuring Bash"
    ln -s ~/workspace/dotfiles-playbook/templates/bash/bashrc ~/.bashrc
    ln -s ~/workspace/dotfiles-playbook/templates/bash/bash_aliases ~/.bash_aliases

    echo -e "\n----- Cleaning up apt -----"
    sudo apt autoclean -y
    sudo apt autoremove -y

    echo -e "\n----- Copying SHH pub key to clipboard -----"
    cat "$SSH_DIR/id_rsa.pub" | xclip -selection c
    echo Add to account here: https://github.com/settings/keys

    echo -e "\n---------------\n"

    echo -e "Provisioning complete"
    echo -e "Reboot the system now"
}

time main
