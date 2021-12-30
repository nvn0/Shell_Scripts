#!/bin/bash
echo "PWD:" $(pwd)
echo "Date:" $(date)
echo "Utilizador:" $(whoami)
echo " "
echo "Memória RAM:"
echo $(free -h)
echo " "
echo "Espaço em Disco:"
echo $(df -h)
echo " "
echo "Dispositivos USB:"
echo $(lsusb)
echo " "



