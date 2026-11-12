#!/usr/bin/env bash

set -euo pipefail

# Script para apagar versões antigas do kernel


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'


CURRENT_KERNEL=$(uname -r)

dpkg-query -W -f='${binary:Package} ${db:Status-Abbrev}\n' \
'linux-headers-*' \
'linux-kbuild-*' \
'linux-image-*' |
awk '$2 ~ /^ii/ {print $1}'

echo
df -h /boot

echo
echo -e "Current kernel: ${GREEN}${CURRENT_KERNEL}${RESET}"
echo
echo -n "Enter the versions numbers (ex: 90,91,95): "
read -r versions

sleep 2

# Convert comma-separated input into an array
IFS=',' read -ra versions_array <<< "$versions"


for version in "${versions_array[@]}"; do

    kernel_version="6.12.$version"

    if [[ "$CURRENT_KERNEL" == "$kernel_version"* ]]; then
        echo -e "${YELLOW}Skipping current kernel: $kernel_version${RESET}"
        continue
    fi

    echo
    echo -e "${YELLOW}Removing kernel: $kernel_version${RESET}"

    sudo apt purge \
        "linux-headers-${kernel_version}+"* \
        "linux-image-${kernel_version}+"* \
        "linux-kbuild-${kernel_version}+"*

done


echo
df -h /boot


