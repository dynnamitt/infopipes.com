tidy_err_log = tidy.errors
AUTO_GEN_FILES =+ sxslt.h* sxslt.xh* $(tidy_err_log)

all:: sxslt.xhtml

sxslt.xhtml: sxslt.html
	-tidy -f $(tidy_err_log) -qci \
		-asxhtml -o $@ $^
	# TODO transform and append css
	#
  # <link type="text/css" rel="stylesheet" media="all" href="info-p-sxml.css" />

sxslt.html: sxslt.tex
# latex 2 html
	hevea -s $^ 
# test
	xmllint --html --noout $@

