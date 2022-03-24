# dotfiles-playbook

### To Use
```
$ sudo apt install git software-properties-common 
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ git clone git@github.com:Ttibsi/dotfiles-playbook.git
$ ansible-galaxy install -r requirements.yml
$ ansible-playbook --ask-become-pass main.yml
```
