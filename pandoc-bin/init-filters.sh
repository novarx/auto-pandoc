cd /pandoc-bin || exit 1
wget "https://github.com/jgm/pandoc/releases/download/2.9.2.1/pandoc-2.9.2.1-linux-amd64.tar.gz" -O "pandoc.tar.gz"
wget "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb" -O "wkhtmltopdf.deb"

tar xvzf "pandoc.tar.gz" --strip-components 1 -C /usr/local/
dpkg -i wkhtmltopdf.deb
cp /pandoc-bin/pandoc-svg.py /usr/local/bin/pandoc-svg
