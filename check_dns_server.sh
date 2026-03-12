#!/bin/bash

# Lista de servidores DNS
DNS_SERVERS=("8.8.8.8" "1.1.1.1" "9.9.9.9" "193.110.81.9")

# Lista de domínios
DOMAINS=("dns0.eu" "google.com" "openai.com" "youtube.com" "duckduckgo.com")

# Timeout para cada consulta
TIMEOUT=2

for SERVER in "${DNS_SERVERS[@]}"; do
    echo "======== Servidor DNS: $SERVER ============"
    for DOMAIN in "${DOMAINS[@]}"; do
        echo "A verificar domínio: $DOMAIN"
        OUTPUT=$(dig @"$SERVER" "$DOMAIN" +stats +time=$TIMEOUT 2>/dev/null)

        if [ $? -eq 0 ]; then
            RESPOSTA=$(echo "$OUTPUT" | grep -v ";" | grep -v "^$")
            LATENCIA=$(echo "$OUTPUT" | grep "Query time" | awk '{print $4}')

            if [ -n "$RESPOSTA" ]; then
                echo "Resposta: $(echo "$RESPOSTA" | head -n 1)"
                echo "Latência: ${LATENCIA} ms"
            else
                echo "Sem resposta para $DOMAIN."
            fi
        else
            echo "Falha ao contactar o servidor $SERVER."
        fi
        echo "-------------------------------"
    done
    echo
done
