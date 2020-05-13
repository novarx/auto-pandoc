FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
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
    python-setuptools
RUN apt-get install -f

# Filters

RUN pip install pandocfilters
RUN pip install pandoc-plantuml-filter

RUN mkdir /pandoc-bin
COPY /pandoc-bin /pandoc-bin
ENV PLANTUML_BIN="java -jar /pandoc-bin/plantuml.jar"

RUN wget "https://github.com/jgm/pandoc/releases/download/2.9.2.1/pandoc-2.9.2.1-linux-amd64.tar.gz" -O "pandoc.tar.gz"
RUN wget "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb" -O "wkhtmltopdf.deb"

RUN chmod -R 744 /pandoc-bin

RUN tar xvzf "pandoc.tar.gz" --strip-components 1 -C /usr/local/
RUN dpkg -i wkhtmltopdf.deb
RUN cp /pandoc-bin/pandoc-svg.py /usr/local/bin/pandoc-svg

RUN mkdir /data
WORKDIR /data
ENTRYPOINT ["/pandoc-bin/start.sh"]
