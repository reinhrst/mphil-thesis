set xrange[150:3150]
set xlabel "Distance from transmitter (mm)"
set ylabel "RSS (dB)
set style line 1 linetype 1 linecolor rgb '#FFDDFF' pointtype 2 pointsize .7;
set style line 2 linetype 1 linecolor rgb 'red' pointtype 2 pointsize .5;
set style line 3 linetype 1 linecolor rgb 'blue' pointtype 2 pointsize .5;
plot "<awk -v filter_channel=37 -f mpi-data.awk ../measurements/mpi_normal.log" ls 1 title 'normal', \
     "<awk -v filter_channel=37 -v divide=5 -f mpi-data.awk ../measurements/mpi_offset.log" ls 2 title 'lateral shift', \
     "<awk -v filter_channel=37 -v divide=7 -f mpi-data.awk ../measurements/mpi_changed_environment.log" ls 3 title 'environment change'
