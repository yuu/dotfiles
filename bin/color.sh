#!/bin/sh

for i in {255..0} ; do
    printf "\x1b[38;5;${i}mcolour${i} "
done
printf "\n"
