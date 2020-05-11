directory=$(pwd)/doc # unix
if [[ "$OSTYPE" == "msys"* ]]; then
  directory=$(pwd -W)/doc # windows
fi
echo "current directory is: $directory"

docker build . --cache-from novarx/pandoc -t novarx/pandoc || exit 1
docker run --rm \
 -v "$directory:/data" \
 novarx/pandoc \
    *.md -o convert-test-document.pdf \
    -V fontsize=12pt \
    -V papersize=a4paper \
    --latex-engine=xelatex \
    --filter=pandoc-plantuml \
    --filter=pandoc-svg
