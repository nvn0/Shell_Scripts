#!/bin/bash


# Variables for colors(text)
RED="\033[31m"
Green="\033[0;32m"
Yellow="\033[0;33m"
Cyan="\033[0;36m"
NC="\033[0m"





echo -e "${Cyan}PWD:${NC}" $(pwd)
echo -e "${Cyan}Date:${NC}" $(date)
echo -e "${Cyan}Up time:${NC}" $(uptime | awk '{print $2 ,$3 ,$4}')
echo -e "${Cyan}Kernel:${NC}" $(uname -r)
echo -e "${Cyan}Utilizador:${NC}" $(whoami)
echo " "
echo -e "${Cyan}Memória RAM:${NC}"
echo $(free -h)
echo " "
echo -e "${Cyan}Espaço em Disco:${NC}"
echo $(df -h)
echo " "
echo -e "${Cyan}Dispositivos USB:${NC}"
echo $(lsusb)
echo " "



