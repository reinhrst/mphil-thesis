include ../Makefile.chapters-shared

.SECONDARY:

heatmap.data: getmaxperposition.awk ../measurements/arch-sw02-offline.log
	awk -v fill=1 -f $+ > $@

heatmap-%-gnuplot.tex: heatmap.gnuplot heatmap.data drawsw02.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; heatmapcolumn=2+0x$(@:heatmap-%-gnuplot.tex=%);" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

localclean:
	rm -f *.data
