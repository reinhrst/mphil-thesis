include ../Makefile.chapters-shared

.SECONDARY:

busyroom-beacon-%.data: takerollingaverage.py ../measurements/busyroom-ble.log
	python $+ $* 600 > $@

busyroom-%-gnuplot.tex: busyroom-beacon-%.data busyroom.gnuplot 
	gnuplot -e  "set terminal epslatex color; set output '$@'; filename='$<';" mpi-single-rss.gnuplot
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

mpi-single-rss-%mm.data: mpi-average.gawk ../measurements/mpi_201403171057.log
	gawk -v average_length_mm=$(@:mpi-single-rss-%mm.data=%) -f mpi-average.gawk ../measurements/mpi_201403171057.log > $@

mpi-data-div%.data: mpi-data.awk ../measurements/mpi_201403171057.log
	awk -v divide=$(@:mpi-data-div%.data=%) -f mpi-data.awk ../measurements/mpi_201403171057.log > $@

mpi-single-rss-%mm-gnuplot.tex: mpi-single-rss-%mm.data mpi-data-div5.data mpi-single-rss.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; filename='$<'; average_length_mm=$(<:mpi-single-rss-%mm.data=%);" mpi-single-rss.gnuplot
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

rot-%-gnuplot.tex: ../measurements/%-none.log ../measurements/%-sitting.log rot.gnuplot rot-data.awk
	gnuplot -e  "set terminal epslatex color; set output '$@'; source='$(@:rot-%-gnuplot.tex=%)';" rot.gnuplot
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

localclean:
	rm -f *.data
