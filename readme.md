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


### add alias

To use the image more like the Pandoc-Command it's recommended to add an _alias_. So it's easier to run a command.
In example the command from above could look as somple as this:

```shell script
pandocker "./02_part1.md" -o converted.pdf --latex-engine=xelatex
```

On Windows add following to the `~/.bashrc` file in the User-Directory when you use [GitBash](https://gitforwindows.org#bash):

```shell script
alias pandocker='docker run --rm -v "$(pwd -W):/data" novarx/pandoc '
```

On Linux you can edit the same File (`~/.bashrc`), but add the `pwd` command without the `-W` Flag:
```shell script
alias pandocker='docker run --rm -v "$(pwd):/data" novarx/pandoc '
```

Of course, instead of `pandocker` you could use whatever you want, like `pandoc` itself or `pan`.



# inspiration & links
- https://github.com/timofurrer/pandoc-plantuml-filter
- https://github.com/jgm/pandoc/issues/265#issuecomment-27317316
- https://github.com/jagregory/pandoc-docker/blob/master/Dockerfile
- https://github.com/pandoc/dockerfiles
