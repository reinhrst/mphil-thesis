include ../Makefile.chapters-shared

.SECONDARY:

busyroom-beacon-%.data: ../measurements/busyroom-ble.log
	grep '$*' $< > $@

busyroom-%-gnuplot.tex: busyroom-beacon-%.data busyroom.gnuplot 
	gnuplot -e  "set terminal epslatex color; set output '$@'; filename='$<';" busyroom.gnuplot
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

mpi-feasibility.data: ../measurements/mpi_normal.log ../measurements/mpi_offset.log ../measurements/mpi_changed_environment.log
	(awk '{if ($$2 == 37) {print $$1, $$3, "1"}}' ../measurements/mpi_normal.log && \
	 awk '{if ($$2 == 37) {print $$1, $$3, "2"}}' ../measurements/mpi_offset.log && \
	 awk '{if ($$2 == 37) {print $$1, $$3, "3"}}' ../measurements/mpi_changed_environment.log) | sort -n > $@

mpi-single-rss-%mm.data: mpi-average.gawk ../measurements/mpi_201403171057.log
	gawk -v average_length_mm=$* -f mpi-average.gawk ../measurements/mpi_201403171057.log > $@

mpi-single-rss-%mm-gnuplot.tex: mpi-single-rss-%mm.data mpi-single-rss.gnuplot
	gnuplot -e  "set terminal epslatex color; set output '$@'; filename='$<'; average_length_mm=$*;" mpi-single-rss.gnuplot
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

frequency-difference-%-gnuplot.tex: frequency-difference.gnuplot ../measurements/arch-sw02-offline.log
	gnuplot -e  "set terminal epslatex color; set output '$@'; x='$(word 1,$(subst -, ,$*))'; y='$(word 2,$(subst -, ,$*))'; beacon='$(word 3,$(subst -, ,$*))'" $<
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

rot-%-gnuplot.tex: ../measurements/%-none.log ../measurements/%-sitting.log rot.gnuplot rot-data.awk
	gnuplot -e  "set terminal epslatex color; set output '$@'; source='$*';" rot.gnuplot
	sed -i '' 's/includegraphics{/includegraphics{$(CURRENT_DIR)\//' $@

correlation-table-generated.tex: correlation.py ../measurements/mpi_201403171057.log ../measurements/mpi_201403171159.log ../measurements/mpi_201403171254.log
	python $+ > $@


localclean:
	rm -f *.data
	rm -f *-generated.tex
