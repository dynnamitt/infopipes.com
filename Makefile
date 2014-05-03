tidy_err_log = tidy.errors
AUTO_GEN_FILES =+ sxslt.h* sxslt.xh* $(tidy_err_log)

sxslt.xhtml: sxslt.html
	-tidy -f $(tidy_err_log) -qci \
		-asxhtml -o $@ $^

sxslt.html: sxslt.tex
# latex 2 html
	hevea -s $^ 
# test
	xmllint --html --noout $@

clean:
	rm -rf $(AUTO_GEN_FILES)
