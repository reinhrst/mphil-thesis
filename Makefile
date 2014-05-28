REPORT=report
CHAPTERS := $(filter-out measurements/.,$(wildcard */.))  # e.g. "foo/. bar/."
TARGETS := prepare cleanup# whatever else, but must not contain '/'

# foo/.all bar/.all foo/.clean bar/.clean
CHAPTERS_TARGETS := \
    $(foreach t,$(TARGETS),$(addsuffix $t,$(CHAPTERS)))



.PHONY : $(REPORT).pdf bibtex open clean $(TARGETS) $(CHAPTERS_TARGETS)

$(REPORT).pdf:
	$(MAKE) prepare
	@awk '/[0-9]+/{sum += $$0;} END {print "Words:"; print sum}' */wordcount.tex > wordcount.tex
	pdflatex -halt-on-error -shell-escape $(REPORT).tex

bibtex: $(REPORT).pdf bibtex.bib
	bibtex $(REPORT)
	$(MAKE) $(REPORT).pdf

open: $(REPORT).pdf
	open $(REPORT).pdf

clean: cleanup
	rm -f $(REPORT).{aux,log,pdf,bbl,blg}

$(TARGETS) : % : $(addsuffix %,$(CHAPTERS))
	@echo 'Done "$*" target'

$(CHAPTERS_TARGETS) :
	$(MAKE) -C $(@D) $(@F:.%=%)
