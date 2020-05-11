#directory=$(pwd)/doc # unix
directory=$(pwd -W)/doc # windows
echo $directory

docker build . -t novarx/pandoc || exit 1
docker run --rm -it \
 -v "$directory:/data" \
 novarx/pandoc
