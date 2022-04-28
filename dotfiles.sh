#!/bin/bash

SSH_DIR="$HOME/.ssh"

# Check out correct branch
if ! [ -z $1 ]; then
    echo ----- Checking out $1 -----
    git checkout -b $1 origin/$1
fi

# Check if ansible is installed
if ! [ -x "$(command -v ansible)" ]; then
    echo ----- Installing ansible -----
    sudo apt install ansible -y
fi

# Generate SSH keys
if ! [[ -f "$SSH_DIR/authorized_keys" ]]; then
    echo ----- Generating SSH key -----
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -C "$USER@$HOSTNAME"
    cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"
fi

# Install ansible requirements
echo ----- Installing requirements -----
ansible-galaxy install -r requirements.yml

ansible-playbook -K main.yml
