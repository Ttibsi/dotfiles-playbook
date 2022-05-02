# dotfiles-playbook

This is an Ansible playbook to install and configure Debian-based systems using my personal configs. This has been tested on Ubuntu 22.04 and Pop OS 22.04, and should work on Ubuntu 21.10 or 20.04 with a few minor tweaks. 

If you choose to use this playbook, I'd recommend looking through the templates folder and picking and choosing configs you want to emulate yourself, as certain parts are keyed to me (such as the gitconfig) as opposed to running this wholesale. 

<Screenshot here>

### What's included here

This dev environment is mostly built around i3-gaps and polybar, with the latest stable version of neovim built from source using the alacritty terminal. Terminal utilities such as [bottom](https://github.com/ClementTsang/bottom) and neofetch are installed, and the desktop apps such as discord and Notion are installed. The snap version of firefox is removed, instead installing the .deb version from the mozillateam PPA, and plugins are installed using a firefox policy.
 
### How to Install


### Still to add
 - I want to build [Firefox](https://firefox-source-docs.mozilla.org/setup/linux_build.html) [Alacritty](https://github.com/alacritty/alacritty/blob/master/INSTALL.md), and [i3-gaps](https://github.com/Airblader/i3/wiki/Building-from-source) from source, which may make them easier to manage in the future.
    - Firefox because of the recent Snap ccontrovercy around Ubuntu 22.04, installing from source will allow me to use the newer version and just not worry about things like that
    - Alacritty because I'm currently using a build that someone else has compiled, and I'd rather have my own control over it
    - i3-gaps is only released for Ubuntu by third-party PPAs, and I'd rather build it from scratch than rely on others, the same as above. 




### To Use
```
$ sudo add-apt-repository --yes --update ppa:ansible/ansible && sudo apt install --yes git ansible software-properties-common 
$ git clone https://github.com/Ttibsi/dotfiles-playbook.git 
$ ansible-galaxy install -r dotfiles-playbook/requirements.yml
$ ansible-playbook --ask-become-pass dotfiles-playbook/main.yml
```
