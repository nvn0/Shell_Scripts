#!/bin/bash

# Create custom commands or commands shortcuts
# alias {custom name to the command}="{comand}"



alias myip="echo $(ifconfig | grep broadcast | awk '{print $2}')"