# Makefile
# 
# Converts Markdown to other formats (HTML, PDF, DOCX, RTF, ODT, EPUB) using Pandoc
# <http://johnmacfarlane.net/pandoc/>
#
# Run "make" (or "make all") to convert to all other formats
#
# Run "make clean" to delete converted files

# Convert all files in this directory that have a .md suffix
SOURCE_DOCS := $(wildcard *.md)

OUTDIR = out

EXPORTED_DOCS=\
 $(OUTDIR)/$(SOURCE_DOCS:.md=.markdown) \
 $(OUTDIR)/$(SOURCE_DOCS:.md=.html) \
 $(OUTDIR)/$(SOURCE_DOCS:.md=.pdf) \
 $(OUTDIR)/$(SOURCE_DOCS:.md=.docx) \
 $(OUTDIR)/$(SOURCE_DOCS:.md=.rtf) \
 $(OUTDIR)/$(SOURCE_DOCS:.md=.odt) \
 $(OUTDIR)/$(SOURCE_DOCS:.md=.epub)

RM=/bin/rm

PANDOC=/opt/homebrew/bin/pandoc

PANDOC_OPTIONS=--standalone --citeproc --csl ieee-with-url.csl

PANDOC_MD_OPTIONS=-t gfm+footnotes-smart
PANDOC_HTML_OPTIONS=--to html5
PANDOC_PDF_OPTIONS= 
PANDOC_DOCX_OPTIONS=
PANDOC_RTF_OPTIONS=
PANDOC_ODT_OPTIONS=
PANDOC_EPUB_OPTIONS=--to epub3


# Pattern-matching Rules

$(OUTDIR)/%.markdown : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_MD_OPTIONS) -o $@ $<

$(OUTDIR)/%.html : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) -o $@ $<

$(OUTDIR)/%.pdf : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $<
	
$(OUTDIR)/%.docx : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o $@ $<

$(OUTDIR)/%.rtf : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_RTF_OPTIONS) -o $@ $<

$(OUTDIR)/%.odt : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_ODT_OPTIONS) -o $@ $<

$(OUTDIR)/%.epub : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_EPUB_OPTIONS) -o $@ $<


# Targets and dependencies

.PHONY: all clean

all : $(EXPORTED_DOCS)

clean:
	- $(RM) $(EXPORTED_DOCS)
