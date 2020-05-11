# Pandoc Docker
[![pipeline status](https://gitlab.com/novarx/pandoc/badges/master/pipeline.svg)](https://gitlab.com/novarx/pandoc/-/commits/master)

## usage
The usage of the dokerized pandoc is equal to the [_pandoc_-CLI](https://pandoc.org/MANUAL.html), just prepend it with a
`docker run novarx/pandoc` with the according volume mapping to `/data` like below: 

```shell script
docker run \
  -v "$(pwd):/data" \
  novarx/pandoc \
      ./02_part1.md \
      -o converted.pdf \
      --latex-engine=xelatex
```

or for bash on a Windows machine (like [GitBash](https://gitforwindows.org#bash)):

```shell script
docker run \
  -v "$(pwd -W):/data" \
  novarx/pandoc \
      ./02_part1.md \
      -o converted.pdf \
      --latex-engine=xelatex
```

The `/data` directory in the container will be the working directory, so i.e. `*.md` resp. `./*.md` in the command
will convert every _.md_ File in the mapped volume. 

# inspiration & links
- https://github.com/timofurrer/pandoc-plantuml-filter
- https://github.com/jgm/pandoc/issues/265#issuecomment-27317316
- https://github.com/jagregory/pandoc-docker/blob/master/Dockerfile
- https://github.com/pandoc/dockerfiles