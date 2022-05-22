# dotfiles-playbook

This is an Ansible playbook to install and configure Debian-based systems using my personal configs. This has been tested on Ubuntu 22.04 and Pop OS 22.04, as well as Ubuntu 21.10. It should also work on 20.04 with a few minor tweaks.

If you choose to use this playbook, I'd recommend looking through the templates folder and picking and choosing configs you want to emulate yourself, as certain parts are keyed to me (such as the gitconfig) as opposed to running this wholesale. 

<Screenshot here>

### What's included here

This dev environment is mostly built around i3-gaps and polybar, with the latest stable version of neovim built from source and using the alacritty terminal. Terminal utilities such as [bottom](https://github.com/ClementTsang/bottom) and neofetch are installed from apt, and the desktop apps such as discord and Notion are installed using .deb files. The snap version of firefox is removed from Ubuntu 22.04, instead installing the .deb version from the mozillateam PPA, and plugins are installed using a firefox policy.
 
### How to Install

 On a fresh install of a supported OS - I recommend a minimal installation - run the following commands one line at a time:
 
 ```
 sudo apt install git -y
 git clone https://github.com/Ttibsi/dotfiles-playbook.git && cd dotfiles-playbook
 ./dotfiles.sh
 ```
 
 You can also specify a different branch with the dotfiles bash file to switch to. IE `./dotfiles.sh test_branch`. Your sudo password will be required multiple times through the install, including when Ansible asks for a `become pass` 
 
 Currently supported OS's
 - Pop OS 22.04 Jammy
 - Ubuntu 22.04 Jammy
 - Ubuntu 21.10 Impish
 
 Note that while these OS's are listed as "supported", things may break in the future and I will not be adjusting to fix things unless I find in the future that I need to, especially for older versions of the names OSes.

### Still to add
 - I want to build [Firefox](https://firefox-source-docs.mozilla.org/setup/linux_build.html) and [Alacritty](https://github.com/alacritty/alacritty/blob/master/INSTALL.md) from source, which may make them easier to manage in the future.
    - Firefox because of the recent Snap controversy around Ubuntu 22.04, installing from source will allow me to use the newer version and just not worry about things like that
    - Alacritty because I'm currently using a build that someone else has compiled, and I'd rather have my own control over it
 
 - I want to add a way to specify which ricing theme to use out of multiple, potentially concatenating to various config files using bash scripts run after the playbook in the main dotfiles 
 - I may also convert over to awesomewm, which I have started to experiment with in the `awesome` branch.
