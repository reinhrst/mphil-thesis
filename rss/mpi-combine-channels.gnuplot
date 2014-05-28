set xrange[150:3150]
unset key
set xlabel "Distance from transmitter (mm)"
set ylabel "RSS (dB)
set style line 1 linetype 1 linecolor rgb 'purple' pointtype 2 pointsize .5;
plot "<awk -f mpi-data.awk ../measurements/mpi_201403171057.log" ls 1;

