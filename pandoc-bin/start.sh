#!/bin/bash
pandoc_arg=''
for var in "$@"; do
    pandoc_arg+="$var "
done
pandoc --version
printf "pandoc_args\n"
echo "pandoc $pandoc_arg"
eval "pandoc $pandoc_arg"
bash
