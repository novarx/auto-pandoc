directory=$(pwd)/test-doc # unix
if [[ "$OSTYPE" == "msys"* ]]; then
  directory=$(pwd -W)/test-doc # windows
fi
echo "current directory is: $directory"
echo "volume mapping is: $directory:/data"

docker build . --cache-from novarx/pandoc -t novarx/pandoc || exit 1
docker run --rm \
 -v "$directory:/data" \
 novarx/pandoc \
    "*.md" \
    -o convert-test-document.pdf \
    -V fontsize=12pt \
    -V papersize=a4paper \
    --pdf-engine=xelatex \
    --filter=pandoc-plantuml \
    --filter=pandoc-svg || exit 1

docker run --rm \
 -v "$directory:/data" \
 novarx/pandoc \
    "02_part1.md" \
    -t html \
    -o convert-via-html-test-document.pdf \
    --css="./style.css" \
    --standalone \
    --pdf-engine=wkhtmltopdf || exit 1
