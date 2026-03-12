#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: $0 <ficheiro>"
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "Erro: ficheiro não encontrado."
    exit 1
fi

# cores
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

# calcular hash
FILE_HASH=$(sha256sum "$FILE" | cut -d' ' -f1)

# pedir hash
read -p "Introduz a hash para comparar: " INPUT_HASH

echo
echo "Hash do ficheiro : $FILE_HASH"
echo "Hash introduzida : $INPUT_HASH"
echo

# comparar
if [ "$FILE_HASH" = "$INPUT_HASH" ]; then
    echo -e "${GREEN}✔ As hashes são iguais${RESET}"
else
    echo -e "${RED}✘ As hashes são diferentes${RESET}"
fi
