tidy_err_log = tidy.errors
info_outline = info-outline.xml

AUTO_GEN_FILES = sxslt.h* sxslt.xh* \
  $(tidy_err_log) $(info_outline)

all: sxslt.xhtml $(info_outline)

sxslt.xhtml: sxslt.html
	-tidy -f $(tidy_err_log) -qci \
		-asxhtml -o $@ $^
	# TODO transform and append css
	#
  #<link type="text/css" rel="stylesheet" media="all" href="info-p-sxml.css" />

sxslt.html: sxslt.tex
# latex 2 html
	hevea -s $^ 
# test
	xmllint --html --noout $@
	
infos = $(wildcard infos/*)
$(info_outline): $(infos)
	ls $(dir $<) > $@

index.xhtml: index.m4 $(info_outline)

clean:
	rm -rf $(AUTO_GEN_FILES)
