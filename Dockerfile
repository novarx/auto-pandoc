FROM ubuntu:18.04

# base dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    nano \
    wget \
    texlive \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-xetex \
    texlive-science \
    texlive-latex-extra \
    texlive-bibtex-extra \
    fontconfig \
    lmodern \
    inkscape \
    xfonts-75dpi \
    xfonts-base \
    npm \
    python-pip \
    python-setuptools \
    default-jdk

# pandoc-crossref
RUN wget "https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.6.2a/pandoc-crossref-Linux-2.9.2.1.tar.xz" && \
    apt-get install xz-utils && \
    tar -x -f pandoc-crossref-Linux-2.9.2.1.tar.xz pandoc-crossref && \
    mv pandoc-crossref /usr/local/bin/ && \
    rm pandoc-crossref*.tar.xz && \
    apt-get install xz-utils

# plantuml filter
RUN pip install pandocfilters
RUN pip install pandoc-plantuml-filter

# binaries
RUN mkdir /pandoc-bin
COPY /pandoc-bin /pandoc-bin
RUN chmod -R +x /pandoc-bin

RUN wget "https://github.com/jgm/pandoc/releases/download/2.9.2.1/pandoc-2.9.2.1-linux-amd64.tar.gz" -O "pandoc.tar.gz"
RUN wget "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb" -O "wkhtmltopdf.deb"

RUN tar xvzf "pandoc.tar.gz" --strip-components 1 -C /usr/local/
RUN dpkg -i wkhtmltopdf.deb
ENV PLANTUML_BIN="java -jar /pandoc-bin/plantuml.jar"
RUN cp /pandoc-bin/pandoc-svg.py /usr/local/bin/pandoc-svg

# data dir
RUN mkdir /data
WORKDIR /data
ENTRYPOINT ["/pandoc-bin/start.sh"]
