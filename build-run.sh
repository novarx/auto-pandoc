directory=$(pwd)/doc # unix
if [[ "$OSTYPE" == "msys"* ]]; then
  directory=$(pwd -W)/doc # windows
fi
echo "current directory is: $directory"

docker build . -t novarx/pandoc || exit 1
docker run --rm -it \
 -v "$directory:/data" \
 novarx/pandoc \
    ./*.md -o dokument.pdf \
    -V fontsize=12pt \
    -V papersize=a4paper \
    --latex-engine=xelatex \
    --filter=pandoc-plantuml \
    --filter=pandoc-svg
