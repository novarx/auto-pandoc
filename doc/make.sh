pandoc *.md -o dokument.pdf \
	-V fontsize=12pt \
	-V papersize=a4paper \
	--latex-engine=xelatex