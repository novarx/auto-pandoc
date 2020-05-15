#!/bin/bash

pandoc_arg=''
for var in "$@"; do
    pandoc_arg+="$var "
done

printf "list dir: %s\n" "$(pwd)"
ls -l

printf "run command:\n"
echo "pandoc $pandoc_arg"
printf "\n"

eval "pandoc $pandoc_arg"
