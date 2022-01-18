#!/bin/bash
# Variables for colors(text)
RED="\033[31m;"
Green="\033[0;32m"
Yellow="\033[0;33m"
Cyan="\033[0;36m"
NC="\033[0m"
echo "PWD:" $(pwd)
echo "Date:" $(date)
echo "Up time:" $(uptime | awk '{print $2 ,$3 ,$4}')
echo "Kernel:" $(uname -r)
echo "Utilizador:" $(whoami)
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
