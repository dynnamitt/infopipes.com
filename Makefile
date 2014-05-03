tidy_err_log = tidy.errors
AUTO_GEN_FILES =+ sxslt.ht* sxslt.xht* $(tidy_err_log)

sxslt.xhtml: sxslt.html
	-tidy -f $(tidy_err_log) -qci \
		-asxhtml -o $@ $^

sxslt.html: sxslt.tex
	hevea -s $^ 
	xmllint --html --noout $@

clean:
	rm -rf $(AUTO_GEN_FILES)
