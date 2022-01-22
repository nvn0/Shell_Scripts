#!/bin/bash

# Create custom commands or commands shortcuts
# alias {custom name to the command}="{comand}"

# adicionar em /home/$USER/.bashrc


alias myip="echo $(ifconfig | grep broadcast | awk '{print $2}')"

alias update='sudo apt update && sudo apt upgrade -y'


alias clean='sudo apt autoremove -y && sudo apt autoclean'








