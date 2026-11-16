#!/usr/bin/env bash

# Script para apagar versões antigas do kernel (criado para debian versoes 6.12.x)

set -euo pipefail

trap 'echo -e "\n${RED}Kernel removal interrupted.${RESET}"; exit 130' INT


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
#echo -e "${CYAN}Installed kernel versions:${RESET}"


#dpkg-query -W -f='${binary:Package} ${db:Status-Abbrev}\n' \
#'linux-image-*' 2>/dev/null |
#awk '$2 ~ /^ii/ {print $1}' |
#sed -n 's/^linux-image-6\.12\.\([0-9]*\)+.*/\1/p' |
#sort -nu |
#tr '\n' ' '; echo



mapfile -t versions < <(
    dpkg-query -W -f='${binary:Package} ${db:Status-Abbrev}\n' \
    'linux-image-*' 2>/dev/null |
    awk '$2 ~ /^ii/ {print $1}' |
    sed -n 's/^linux-image-6\.12\.\([0-9]*\)+.*/\1/p' |
    sort -nu
)

echo -ne "${CYAN}Installed kernel versions:${RESET} "

for i in "${!versions[@]}"; do
    version="${versions[$i]}"

    if (( i >= ${#versions[@]} - 2 )); then
        echo -ne "${RED}${version}${RESET} "
    else
        echo -ne "${GREEN}${version}${RESET} "
    fi
done


# Protect the two most recent kernel versions
PROTECTED_VERSIONS=("${versions[@]: -2}")



echo
echo -e "Current kernel: ${YELLOW}${CURRENT_KERNEL}${RESET}"
echo
echo -n "Enter the versions numbers (ex: 90,91,95): "
read -r versions_input



sleep 2

# Convert comma-separated input into an array
IFS=',' read -ra versions_array <<< "$versions_input"



for version in "${versions_array[@]}"; do

    kernel_version="6.12.$version"

    if [[ "$CURRENT_KERNEL" == "$kernel_version"* ]]; then
        echo -e "${YELLOW}Skipping current kernel: $kernel_version${RESET}"
        continue
    fi

    # Protect two most recent kernels
    if [[ " ${PROTECTED_VERSIONS[*]} " == *" $version "* ]]; then # verifica se o número da versão que estás a tentar remover existe dentro do array PROTECTED_VERSIONS
        echo -e "${YELLOW}Skipping protected kernel: $kernel_version${RESET}"
        continue
    fi

    echo
    echo -e "${YELLOW}Removing kernel: $kernel_version${RESET}"

    if sudo apt purge \
        "linux-headers-${kernel_version}+"* \
        "linux-image-${kernel_version}+"* \
        "linux-kbuild-${kernel_version}+"*; then

        echo -e "${GREEN}Kernel removal completed.${RESET}"

    else
        echo -e "${RED}Kernel removal stopped or failed.${RESET}"
    fi

done


echo
df -h /boot


