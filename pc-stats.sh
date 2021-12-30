#!/bin/bash

echo $(pwd)
echo $(date)
echo $(who)
echo " "
echo "Memória RAM:"
echo $(free -h)
echo " "
echo "Espaço em Disco:"
echo $(df -h)
echo " "
echo "Dispositivos USB:"
echo $(lsusb)



