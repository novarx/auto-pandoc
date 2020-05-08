directory=$(pwd)/doc
directory=C:/dev/pandoc/doc
echo $directory
docker build . -t novarx/pandoc
docker run --rm -it \
 -v $directory:/data \
 novarx/pandoc
