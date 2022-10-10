# dotfiles-playbook

This is an Ansible playbook to install and configure Debian-based systems using 
my personal configs. This is designed to work on PopOS 22.04, but may also work 
on Ubuntu 22.04 or 20.04 with a few tweaks. 

If you choose to use this playbook, I'd recommend looking through the templates 
folder and picking and choosing configs you want to emulate yourself, as certain 
parts are keyed to me (such as the gitconfig) as opposed to running this wholesale. 

![Main screenshot](https://user-images.githubusercontent.com/60970073/172371773-d3e91b4c-21ec-4dde-b2bd-fe1eab7914e8.png)

### What's included here

This dev environment is mostly built around i3-gaps and polybar, with the 
latest stable version of neovim built from source and using the alacritty 
terminal. Terminal utilities such as [bottom](https://github.com/ClementTsang/bottom) 
and neofetch are installed from apt, and the desktop apps such as discord 
and Notion are installed using .deb files and flatpak. firefox plugins are 
installed using an enterprise policy.
 
### How to Install

 On a fresh install of a supported OS - I recommend a minimal installation - run 
 the following commands one line at a time:
 
 ```
 sudo apt install git -y
 git clone https://github.com/Ttibsi/dotfiles-playbook.git && cd dotfiles-playbook
 ./dotfiles.sh
 ```
 
 You can also specify a different branch with the dotfiles bash file to switch 
 to. IE `./dotfiles.sh test_branch`. Your sudo password will be required 
 multiple times through the install, including when Ansible asks for a 
 `become pass` 
 
 Currently supported OS's
 - Pop OS 22.04 Jammy
 - Ubuntu 22.04 Jammy (Untested since revisions)
 
 Note that while these OS's are listed as "supported", things may break in the 
 future and I will not be adjusting to fix things unless I find in the future 
 that I need to, especially for older versions of the names OSes.

### Still to add
 - I want to add a way to specify which ricing theme to use out of multiple, 
 potentially concatenating to various config files using bash scripts run 
 after the playbook in the main dotfiles 

 - There are also a few minor things in the environment that need tweaks, such 
 as using icons on the wifi section of polybar, and tweaking the appearance 
 of the dunst notifications 
