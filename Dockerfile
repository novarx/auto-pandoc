FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    nano \
    pandoc \
    texlive \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-xetex \
    texlive-science \
    texlive-latex-extra \
    texlive-bibtex-extra \
    fontconfig \
    lmodern \
    inkscape

RUN wget -c "https://github.com/lierdakil/pandoc-crossref/releases/download/v0.4.0.0-alpha6d/pandoc-crossref-Linux-2.9.2.1.tar.xz" -O | tar -xz

RUN mkdir /data
RUN mkdir /pandoc-bin
COPY ./bin /pandoc-bin

WORKDIR /data
CMD ["bash"]