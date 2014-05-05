articles_outline = art-outline.xml
articles = $(wildcard articles/*.article.m4)

AUTO_GEN_FILES = $(articles_outline) index.xhtml

all :: index.xhtml

include aux.mk

$(articles_outline): $(articles)

index.xhtml: index.m4 $(articles_outline)
	m4 $< > $@

clean:
	rm -rf $(AUTO_GEN_FILES)
