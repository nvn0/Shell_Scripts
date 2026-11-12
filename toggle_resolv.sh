#!/usr/bin/bash

# Script que apenas coloca o resolv.conf imutavel

FILE="/etc/resolv.conf"


if ! lsattr "${FILE}" &> /dev/null; then
    echo "Erro: não foi possível verificar atributos de ${FILE}"
    exit 1
fi

# Verifica se o atributo immutable está presente
if lsattr "${FILE}" | grep -q 'i'; then
    echo "A remover atributo imutável de ${FILE}"
    sudo chattr -i "${FILE}" && echo "=> Agora é mutável."
else
    echo "A definir atributo imutável em ${FILE}"
    sudo chattr +i "${FILE}" && echo "=> Agora é imutável."
fi
