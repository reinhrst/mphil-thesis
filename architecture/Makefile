include ../Makefile.chapters-shared

.SECONDARY:

fingerprint-database.data: generate-fingerprint-database.py ../measurements/arch-sw02-offline.log ../measurements/beacon-list
	python $+ > $@

walk-%.data: generate-fingerprint-database.py ../measurements/arch-sw02-walk-%.log ../measurements/beacon-list
	python $+ > $@

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
