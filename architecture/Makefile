include ../Makefile.chapters-shared

.SECONDARY:

fingerprint-database-heading-width-%.data: generate-fingerprint-database.py ../measurements/arch-sw02-offline.log ../measurements/beacon-list
	python $+ $* > $@

walk-%.data: generate-fingerprint-database.py ../measurements/arch-sw02-walk-%.log ../measurements/beacon-list
	python $+ 90 > $@

short-walk-1-%s.data: generate-fingerprint-database.py ../measurements/arch-sw02-walk-1.log ../measurements/beacon-list
	python $+ 90 $* > $@

short-walk-2-%s.data: generate-fingerprint-database.py ../measurements/arch-sw02-walk-2.log ../measurements/beacon-list
	python $+ 90 $* > $@

short-walk-3-%s.data: generate-fingerprint-database.py ../measurements/arch-sw02-walk-3.log ../measurements/beacon-list
	python $+ 90 $* > $@

short-positioning-stats-%s.data: position.py fingerprint-database-heading-width-120.data short-walk-1-%s.data short-walk-2-%s.data short-walk-3-%s.data
	python $< 'SSD SSD-O BRP BRP-RPM' fingerprint-database-heading-width-120.data short-walk-1-$*s.data short-walk-2-$*s.data short-walk-3-$*s.data >/dev/null 2> $@

positioning-compass-error.data: position.py fingerprint-database-heading-width-120.data walk-1.data walk-2.data walk-3.data
	python position.py "SSD $$(seq 0 10 180 | sed 's/^/SSD-C/' | tr '\n' ' ')" fingerprint-database-heading-width-120.data walk-1.data walk-2.data walk-3.data >$@ 2>/dev/null

positioning-heading-width-%.data positioning-stats-heading-width-%.data: position.py fingerprint-database-heading-width-%.data walk-1.data walk-2.data walk-3.data
	python $< 'Random SSD SSD-O BRP BRP-RPM' fingerprint-database-heading-width-$*.data walk-1.data walk-2.data walk-3.data > positioning-heading-width-$*.data 2> positioning-stats-heading-width-$*.data

positioning-stats-beaconcount-%.data:position.py fingerprint-database-heading-width-120.data walk-1.data walk-2.data walk-3.data 
	BEACONCOUNT=$* python position.py "SSD SSD-O BRP BRP-RPM" fingerprint-database-heading-width-120.data walk-1.data walk-2.data walk-3.data 2>$@ >/dev/null

positioning-stats-livebeaconcount-%.data:position.py fingerprint-database-heading-width-120.data walk-1.data walk-2.data walk-3.data 
	LIVEBEACONCOUNT=$* python position.py "SSD SSD-O BRP BRP-RPM" fingerprint-database-heading-width-120.data walk-1.data walk-2.data walk-3.data 2>$@ >/dev/null

positioning-stats-surveypointpart-%.data:position.py fingerprint-database-heading-width-120.data walk-1.data walk-2.data walk-3.data 
	SURVEYPOINTPART=$* python position.py "SSD SSD-O BRP BRP-RPM" fingerprint-database-heading-width-120.data walk-1.data walk-2.data walk-3.data 2>$@ >/dev/null

#results.generated.tex: positioning-stats-heading-width-120.data
#	awk -f generateresults.awk $< > $@

ssd-o-parameter-effect-heading-width-%.data: position.py fingerprint-database-heading-width-%.data walk-1.data walk-2.data walk-3.data
	python $< 'SSD-O1 SSD-O2 SSD-O5 SSD-O10 SSD-O30 SSD-O60 SSD-O90 SSD-O120 SSD-O180' fingerprint-database-heading-width-$*.data walk-1.data walk-2.data walk-3.data > /dev/null 2> $@


SSD_O_PARAM_SRC=ssd-o-parameter-effect-heading-width-30.data ssd-o-parameter-effect-heading-width-45.data ssd-o-parameter-effect-heading-width-60.data ssd-o-parameter-effect-heading-width-75.data ssd-o-parameter-effect-heading-width-90.data ssd-o-parameter-effect-heading-width-120.data ssd-o-parameter-effect-heading-width-180.data

ssd-o-parameter-effect.data: choose-column-from-multiple-files.py positioning-stats-heading-width-60.data ${SSD_O_PARAM_SRC}
	(for in in $$(seq $$(wc -l $(firstword ${SSD_O_PARAM_SRC})| awk '{print $$1}')); do grep 'SSD ' positioning-stats-heading-width-60.data ; done ) | python $< 5 ${SSD_O_PARAM_SRC} '-' > $@

#positioning-errors-difference-%-gnuplot.tex: positioning-errors-difference.gnuplot positioning-heading-width-60.data drawsw02.gnuplot
#	gnuplot -e  "set terminal epslatex size 13.75cm,11cm color; set output '$@'; plottype1='$(firstword $(subst _, ,$*))'; plottype2='$(word 2,$(subst _, ,$*))'" $<
#	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@


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



short-walk-gnuplot.tex: short-walk.gnuplot short-positioning-stats-0.1s.data short-positioning-stats-0.25s.data short-positioning-stats-0.5s.data short-positioning-stats-1.0s.data short-positioning-stats-1.5s.data short-positioning-stats-2.0s.data
	gnuplot -e  "set terminal epslatex size 13.75cm,11cm color; set output '$@';" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

positioning-errors-%-gnuplot.tex: positioning-errors.gnuplot positioning-heading-width-120.data drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex size 13.75cm,11cm color; set output '$@'; plottype='$*';" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

heatmap-%-mean-gnuplot.tex: heatmap.gnuplot fingerprint-database.data drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; heatmapbeacon=0x0$*; heatmapcolumn=7" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

heatmap-%-max-gnuplot.tex: heatmap.gnuplot fingerprint-database.data drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; heatmapbeacon=0x0$*; heatmapcolumn=5" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

heatmap-%-rpm-gnuplot.tex: heatmap.gnuplot fingerprint-database.data drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; heatmapbeacon=0x0$*; heatmapcolumn=8" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

heatmap-%-rot-0-gnuplot.tex: heatmap.gnuplot fingerprint-database.data drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; heatmapbeacon=0x0$*; heatmapcolumn=9" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

localclean:
	rm -f *.data
	rm -f *.generated.tex
