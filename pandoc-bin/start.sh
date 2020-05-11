#!/bin/bash
pandoc_arg=''
for var in "$@"; do
    pandoc_arg+="$var "
done
printf "pandoc_args\n"
echo "pandoc $pandoc_arg"
bash -c "pandoc $pandoc_arg"
bash
