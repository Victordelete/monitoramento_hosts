#!/bin/bash

HOSTS="hosts/hosts.txt"
OUT_FILE="log/log.txt"

declare -i DELAY=1 # Tempo de espera
declare -i REPEAT=5 # Vezes para repetir o ping

echo "Script de monitoramento em execucao..."

# Read HOSTS line by line
while read -r line; do
    c=0
    while [[ $c < $REPEAT ]]; do
        fping -c $DELAY $line >&/dev/null
        if [[ $? -eq 0 ]]; then
                echo "$line Success  $(date +"%D %T")" >> $OUT_FILE #Saida de sucesso
                break
        fi

        (( c++ ))
    done

    # Final do ciclo com falha 
    if [[ $c == $REPEAT ]]; then 
        echo "$line Failed $(date +"%D %T")" >> $OUT_FILE #Log de testes
    fi

done < $HOSTS

echo "Script de monitoramento finalizado."
echo ""