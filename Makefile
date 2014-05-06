articles_outline = art-outline.m4
xsl_ns=http://www.w3.org/1999/XSL/Transform
ht_ns=http://www.w3.org/1999/xhtml
articles_SRC = $(wildcard articles/*.article)
articles = $(patsubst %.article,%.xhtml,$(articles_SRC))

#
# $(call xpath,{query},{indoc})
define xpath
xmllint --xpath '$1' $2
endef

#
# $(call fdate,{file})
define fdate
date +'%Y%m%dT%H:%M' -r $1
endef

#
# $(call nodir_stem,{path})
define nodir_stem
echo "$1" | sed 's/.*\/\([^\.]*\)\..*/\1/'
endef

q_art_title = //article/h1/text()

AUTO_GEN_FILES = $(articles_outline) index.xhtml $(articles)

all :: index.xhtml $(articles) 

include aux.mk

articles/%.xhtml: articles/%.article layout.m4
	cp $< $@

$(articles_outline): $(articles_SRC)
	for src in $(sort $^); do \
	  art_name=$$($(call nodir_stem,$${src})) ; \
	  tit=$$($(call xpath,$(q_art_title),$${src})) ; \
	  date=$$($(call fdate,$${src})) ; \
	  echo "ART(\`$${art_name}',\`$${tit}',\`$${date}')"; \
	done > $@

index.xhtml: index.m4 $(articles_outline) layout.m4
	m4 $< > $@

clean:
	rm -rf $(AUTO_GEN_FILES)
