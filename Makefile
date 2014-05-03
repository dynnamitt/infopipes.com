info_outline = info-outline.xml

AUTO_GEN_FILES = $(info_outline)

all: sxslt.xhtml $(info_outline)

	
infos = $(wildcard infos/*)
$(info_outline): $(infos)
	ls $(dir $<) > $@

index.xhtml: index.m4 $(info_outline)

clean:
	rm -rf $(AUTO_GEN_FILES)


# external stuff;

# TODO move to .mk file
tidy_err_log = tidy.errors 

AUTO_GEN_FILES += $(tidy_err_log) sxslt.h* sxslt.xh*

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

