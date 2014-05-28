set xrange[150:3150]
set yrange[-90:-30]
set xlabel "Distance from transmitter (mm)"
set ylabel "RSS (dB)
set style line 1 linetype 1 linecolor rgb 'red' pointtype 2 pointsize .5;
set style line 2 linetype 1 linecolor rgb 'green' pointtype 2 pointsize .5;
set style line 3 linetype 1 linecolor rgb 'blue' pointtype 2 pointsize .5;
plot "<awk -v filter_channel=37 -v divide=5 -f mpi-data.awk ../measurements/mpi_201403171057.log" ls 1 title 'channel 37', \
     "<awk -v filter_channel=38 -v divide=5 -f mpi-data.awk ../measurements/mpi_201403171057.log" ls 2 title 'channel 38', \
     "<awk -v filter_channel=39 -v divide=5 -f mpi-data.awk ../measurements/mpi_201403171057.log" ls 3 title 'channel 39'
