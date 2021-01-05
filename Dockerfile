FROM ubuntu:18.04

# base dependencies
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    nano \
    wget \
    texlive \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-xetex \
    texlive-fonts-extra \
    texlive-science \
    texlive-latex-extra \
    texlive-bibtex-extra \
    fontconfig \
    lmodern \
    inkscape \
    xfonts-75dpi \
    xfonts-base \
    graphviz \
    librsvg2-bin

RUN apt-get install -y --no-install-recommends \
    npm \
    python-pip \
    python-setuptools \
    python3 \
    python3-pip \
    python3-setuptools \
    default-jdk

# pandoc-crossref
RUN wget "https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.9.0/pandoc-crossref-Linux.tar.xz" && \
    apt-get install xz-utils && \
    tar -x -f pandoc-crossref-Linux.tar.xz pandoc-crossref && \
    mv pandoc-crossref /usr/local/bin/ && \
    rm pandoc-crossref*.tar.xz && \
    apt-get install xz-utils
RUN apt-get install -y pandoc-citeproc

# plantuml filter
RUN pip install pandocfilters
RUN pip3 install weasyprint
RUN pip install pandoc-plantuml-filter

# binaries
RUN mkdir /pandoc-bin
COPY /pandoc-bin /pandoc-bin
RUN chmod -R +x /pandoc-bin

# plantuml filter
RUN cp /pandoc-bin/pandoc-plantuml-filter.py /usr/local/bin/pandoc-plantuml

RUN wget "https://github.com/jgm/pandoc/releases/download/2.11.3.1/pandoc-2.11.3.1-linux-amd64.tar.gz" -O "pandoc.tar.gz"
RUN wget "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb" -O "wkhtmltopdf.deb"

RUN tar xvzf "pandoc.tar.gz" --strip-components 1 -C /usr/local/
RUN dpkg -i wkhtmltopdf.deb
ENV PLANTUML_BIN="java -jar /pandoc-bin/plantuml.jar"
RUN cp /pandoc-bin/pandoc-svg.py /usr/local/bin/pandoc-svg

RUN cp /pandoc-bin/fonts/* /usr/share/fonts/truetype
RUN fc-cache -f -v

# data dir
RUN mkdir /data
WORKDIR /data
ENTRYPOINT ["/pandoc-bin/start.sh"]
