directory=$(pwd)/doc # unix
if [[ "$OSTYPE" == "msys"* ]]; then
  directory=$(pwd -W)/doc # windows
fi
echo "current directory is: $directory"

docker build . --cache-from novarx/pandoc -t novarx/pandoc || exit 1
docker run --rm \
 -v "$directory:/data" \
 novarx/pandoc \
    "*.md" \
    -t html5 \
    -o convert-test-document.pdf \
    --css "./style.css" \
    -V fontsize=12pt \
    -V papersize=a4paper \
    --pdf-engine=xelatex \
    --filter=pandoc-plantuml \
    --filter=pandoc-svg

docker run --rm \
 -v "$directory:/data" \
 novarx/pandoc \
    "02_part1.md" \
    -t html \
    -o convert-via-html-test-document.pdf \
    --css="./style.css" \
    --standalone \
    --pdf-engine=wkhtmltopdf