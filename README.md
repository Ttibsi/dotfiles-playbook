# dotfiles-playbook

### To Use
```
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install --yes git ansible software-properties-common 
$ git clone https://github.com/Ttibsi/dotfiles-playbook.git 
$ ansible-galaxy install -r dotfiles-playbook/requirements.yml
$ ansible-playbook --ask-become-pass dotfiles-playbook/main.yml
```
