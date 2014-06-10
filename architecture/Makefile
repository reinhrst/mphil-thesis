include ../Makefile.chapters-shared

.SECONDARY:

DML=SSD SSD-O BRP BRP-O BRP-RPM
FPD=fingerprint-database-heading-width-120-180.data
RUNS=100

fingerprint-database-heading-width-%.data: generate-fingerprint-database.py ../measurements/arch-sw02-offline.log ../measurements/beacon-list
	python $+ $* > $@

walk-%.data: generate-fingerprint-database.py ../measurements/arch-sw02-walk-%.log ../measurements/beacon-list
	python $+ x > $@

short-walk-1-%s.data: generate-fingerprint-database.py ../measurements/arch-sw02-walk-1.log ../measurements/beacon-list
	python $+ x $* > $@

short-walk-2-%s.data: generate-fingerprint-database.py ../measurements/arch-sw02-walk-2.log ../measurements/beacon-list
	python $+ x $* > $@

short-walk-3-%s.data: generate-fingerprint-database.py ../measurements/arch-sw02-walk-3.log ../measurements/beacon-list
	python $+ x $* > $@

short-positioning-stats-%s.data: position.py ${FPD} short-walk-1-%s.data short-walk-2-%s.data short-walk-3-%s.data
	python $< '${DML}' ${FPD} short-walk-1-$*s.data short-walk-2-$*s.data short-walk-3-$*s.data >/dev/null 2> $@

positioning-compass-error-%.data: position.py ${FPD} walk-1.data walk-2.data walk-3.data
	python position.py "$(shell echo $* | tr a-z A-Z) $$(seq 0 10 180 | sed 's/^/$(shell echo $* | tr a-z A-Z)-C/' | tr '\n' ' ')" ${FPD} walk-1.data walk-2.data walk-3.data >$@ 2>/dev/null

positioning-compass-error-%-gnuplot.tex: positioning-compass-error.gnuplot positioning-compass-error-%.data
	gnuplot -e  "set terminal epslatex color; set output '$@'; target='$(word 2,$+)';type='$(shell echo $* | tr a-z A-Z)';" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

positioning-heading-width-%.data positioning-stats-heading-width-%.data: position.py fingerprint-database-heading-width-%.data walk-1.data walk-2.data walk-3.data
	python $< 'Random ${DML}' fingerprint-database-heading-width-$*.data walk-1.data walk-2.data walk-3.data > positioning-heading-width-$*.data 2> positioning-stats-heading-width-$*.data

positioning-stats-beaconcount-%.data:position.py ${FPD} walk-1.data walk-2.data walk-3.data 
	RUNS=${RUNS} BEACONCOUNT=$* python position.py "${DML}" ${FPD} walk-1.data walk-2.data walk-3.data 2>$@ >/dev/null

positioning-stats-livebeaconcount-%.data:position.py ${FPD} walk-1.data walk-2.data walk-3.data 
	RUNS=${RUNS} LIVEBEACONCOUNT=$* python position.py "${DML}" ${FPD} walk-1.data walk-2.data walk-3.data 2>$@ >/dev/null

positioning-stats-surveypointpart-%.data:position.py ${FPD} walk-1.data walk-2.data walk-3.data 
	RUNS=${RUNS} SURVEYPOINTPART=$* python position.py "${DML}" ${FPD} walk-1.data walk-2.data walk-3.data 2>$@ >/dev/null

ssd-o-parameter-effect-heading-width-%.data: position.py fingerprint-database-heading-width-%-180.data walk-1.data walk-2.data walk-3.data
	python $< 'SSD-O1 SSD-O2 SSD-O5 SSD-O10 SSD-O30 SSD-O60 SSD-O90 SSD-O120 SSD-O180' fingerprint-database-heading-width-$*-180.data walk-1.data walk-2.data walk-3.data > /dev/null 2> $@

SSD_O_PARAM_DEPS=$(addprefix ssd-o-parameter-effect-heading-width-, $(addsuffix .data,30 45 60 75 90 120 180))

ssd-o-parameter-effect.data: choose-column-from-multiple-files.py positioning-stats-heading-width-120-180.data ${SSD_O_PARAM_DEPS}
	(for in in $$(seq $$(wc -l $(firstword ${SSD_O_PARAM_DEPS})| awk '{print $$1}')); do grep 'SSD ' positioning-stats-heading-width-120-180.data ; done ) | python $< 5 ${SSD_O_PARAM_DEPS} '-' > $@

brp-o-parameter-effect-heading-width-%.data: position.py fingerprint-database-heading-width-120-%.data walk-1.data walk-2.data walk-3.data
	python $< 'BRP-O1 BRP-O2 BRP-O5 BRP-O10 BRP-O30 BRP-O60 BRP-O90 BRP-O120 BRP-O180' fingerprint-database-heading-width-120-$*.data walk-1.data walk-2.data walk-3.data > /dev/null 2> $@

BRP_O_PARAM_DEPS=$(addprefix brp-o-parameter-effect-heading-width-, $(addsuffix .data,30 45 60 75 90 120 180))

brp-o-parameter-effect.data: choose-column-from-multiple-files.py positioning-stats-heading-width-120-180.data ${BRP_O_PARAM_DEPS}
	(for in in $$(seq $$(wc -l $(firstword ${BRP_O_PARAM_DEPS})| awk '{print $$1}')); do grep 'BRP ' positioning-stats-heading-width-120-180.data ; done ) | python $< 5 ${BRP_O_PARAM_DEPS} '-' > $@

%-o-parameter-effect-gnuplot.tex: %-o-parameter-effect.data o-parameter-effect.gnuplot
	gnuplot -e  "set terminal epslatex size 13.75cm,11cm color; set output '$@'; type='$*'; target='$<'" o-parameter-effect.gnuplot
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

BEACONCOUNTDEPS = $(addprefix positioning-stats-beaconcount-, $(addsuffix .data,1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))

beaconcount-gnuplot.tex: beaconcount.gnuplot $(BEACONCOUNTDEPS)
	gnuplot -e  "set terminal epslatex size 13.75cm,11cm color; set output '$@'; beaconcountdeps='$(BEACONCOUNTDEPS)'" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

LIVEBEACONCOUNTDEPS = $(addprefix positioning-stats-livebeaconcount-, $(addsuffix .data,1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))
livebeaconcount-gnuplot.tex: livebeaconcount.gnuplot $(LIVEBEACONCOUNTDEPS)
	gnuplot -e  "set terminal epslatex size 13.75cm,11cm color; set output '$@'; livebeaconcountdeps='$(LIVEBEACONCOUNTDEPS)'" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

SURVEYPOINTPARTDEPS = $(addprefix positioning-stats-surveypointpart-, $(addsuffix .data,0.025 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.6 0.7 0.8 0.9 1))
surveypointpart-gnuplot.tex: surveypointpart.gnuplot $(SURVEYPOINTPARTDEPS)
	gnuplot -e  "set terminal epslatex size 13.75cm,11cm color; set output '$@'; surveypointpartdeps='$(SURVEYPOINTPARTDEPS)'" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@


SHORTWALKDEPS = $(addprefix short-positioning-stats-, $(addsuffix s.data,0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.2 1.4 1.6 1.8 2.0))
short-walk-gnuplot.tex: short-walk.gnuplot ${SHORTWALKDEPS}
	gnuplot -e  "set terminal epslatex size 13.75cm,11cm color; set output '$@'; shortwalkdeps='$(SHORTWALKDEPS)';" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

short-walk-unobserved-beacons.data: ${SHORTWALKDEPS}
	for i in $$(ls short-walk-1-???s.data | sed 's/short-walk-1-\(.*\)s.data/\1/' | sort -n); do echo -n $$i; awk '{if ($$6 == -105) {print FILENAME, $$1, $$2}}'  short-walk-?-$${i}s.data | uniq | wc -l; done > $@


positioning-type-%.data: position.py ${FPD} walk-1.data walk-2.data walk-3.data
	python $< $* ${FPD} walk-1.data walk-2.data walk-3.data > $@ 2> /dev/null

positioning-errors-%-gnuplot.tex: positioning-type-%.data positioning-errors.gnuplot drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex size 13.75cm,11cm color; set output '$@'; filename='$<';" positioning-errors.gnuplot
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

heatmap-%-mean-gnuplot.tex: heatmap.gnuplot ${FPD} drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; heatmapbeacon=0x0$*; heatmapcolumn=7" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

heatmap-%-max-gnuplot.tex: heatmap.gnuplot ${FPD} drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; heatmapbeacon=0x0$*; heatmapcolumn=6" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

heatmap-%-rpm-gnuplot.tex: heatmap.gnuplot ${FPD} drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; heatmapbeacon=0x0$*; heatmapcolumn=8" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

heatmap-%-ssd-o-0-gnuplot.tex: heatmap.gnuplot ${FPD} drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; heatmapbeacon=0x0$*; heatmapcolumn=9" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

heatmap-%-brp-o-0-gnuplot.tex: heatmap.gnuplot ${FPD} drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; heatmapbeacon=0x0$*; heatmapcolumn=10" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

rss-cloud-%s-gnuplot.tex: rss-cloud.gnuplot rss-cloud.py ${FPD} short-walk-1-%s.data short-walk-2-%s.data short-walk-3-%s.data
	gnuplot -e  "set terminal epslatex color; set output '$@'; filename='<python $(filter-out $<,$+)';" $<
	sed -Ei '' 's/includegraphics{([^}]*)}/includegraphics{$(CURRENT_DIR)\/{\1}.eps}/' $@

localclean:
	rm -f *.data
	rm -f *.generated.tex
