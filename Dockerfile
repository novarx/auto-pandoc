FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y --no-install-recommends nano
RUN apt-get install -y --no-install-recommends pandoc
RUN apt-get install -y --no-install-recommends texlive
RUN apt-get install -y --no-install-recommends texlive-generic-recommended
RUN apt-get install -y --no-install-recommends texlive-latex-base
RUN apt-get install -y --no-install-recommends texlive-xetex
RUN apt-get install -y --no-install-recommends texlive-science
RUN apt-get install -y --no-install-recommends texlive-latex-extra
RUN apt-get install -y --no-install-recommends texlive-bibtex-extra
RUN apt-get install -y --no-install-recommends fontconfig
RUN apt-get install -y --no-install-recommends lmodern
RUN apt-get install -y --no-install-recommends inkscape
RUN apt-get install -y --no-install-recommends plantuml

RUN apt-get install -y --no-install-recommends npm

RUN apt-get install -y --no-install-recommends python-pip
RUN apt-get install -y --no-install-recommends python-setuptools

# Filters
RUN pip install pandocfilters
RUN pip install pandoc-plantuml-filter

RUN mkdir /pandoc-bin
COPY /pandoc-bin /pandoc-bin
RUN chmod -R 744 /pandoc-bin
ENV PLANTUML_BIN="java -jar /pandoc-bin/plantuml.jar"
#RUN cp /pandoc-bin/pandoc-plantuml-filter.py /usr/local/bin/pandoc-plantuml
RUN cp /pandoc-bin/pandoc-svg.py /usr/local/bin/pandoc-svg

RUN mkdir /data
WORKDIR /data
ENTRYPOINT ["/pandoc-bin/start.sh"]