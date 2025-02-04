#!/bin/sh

for i in {0..255}; do
    printf "\033[48;5;%sm %3d \033[0m" "$i" "$i"
    if [ $(( (i+1) % 16 )) -eq 0 ]; then
        echo
    fi
done
