#!/bin/bash

SSH_DIR="$HOME/.ssh"

function gnome {
    echo -e "Configuring Gnome"
    gsettings set org.gnome.desktop.interface show-battery-percentage true
    xdotool key super+y # Enable pop tiling

    sudo apt install uuid-runtime

    export TERMINAL=gnome-terminal

    current_profile_id=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "[]'")
    new_profile_id=$(uuidgen)
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$new_profile_id/ name "Default"
    gsettings set org.gnome.Terminal.ProfilesList default $new_profile_id
    gsettings reset-recursively org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$current_profile_id/
    echo "Profile switched to 'Default' and old profile deleted."

    curl https://raw.githubusercontent.com/Gogh-Co/Gogh/master/installs/clone-of-ubuntu.sh -o $HOME/Downloads/clone-of-ubuntu.sh
    chmod +x $HOME/Downloads/clone-of-ubuntu.sh
    . $HOME/Downloads/clone-of-ubuntu.sh
}

function i3 {
    echo -e "Configuring i3"
    ansible-playbook -K tasks/i3.yml
}

function main {
    # Check out correct branch
    if ! [ -z $1 ]; then
        echo ----- Checking out $1 -----
        git checkout -b $1 origin/$1
    fi

    echo "Select a Desktop Environment to configure (or empty for all)"
    echo "1 - GNOME"
    echo "2 - i3"

    read -p "> " de_choice

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

    ansible-playbook -K main.yml

    case "$de_choice" in 
        1)
            gnome
            ;;
        2)
            i3
            ;;
        *)
            gnome
            i3
            ;;
    esac

    echo -e "\n----- Removing ansible requirements -----"
    rm -rf $HOME/.ansible

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
