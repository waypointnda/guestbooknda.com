mustache=node_modules/.bin/mustache
pages=$(wildcard *.mustache.html)
targets=$(pages:.mustache.html=.html) versions.xml logo.png

all: $(targets)

%.html: view.json %.mustache.html tidy.config | $(mustache) site
	$(mustache) view.json $*.mustache.html | tidy -config tidy.config > $@

versions.xml: view.json versions.mustache.xml tidy.config | $(mustache) site
	$(mustache) view.json versions.mustache.xml | xmllint --format - > $@

%.png: %.svg
	convert $< $@

site:
	mkdir -p site

$(mustache):
	npm ci

.PHONY: clean

clean:
	rm -f $(targets)
