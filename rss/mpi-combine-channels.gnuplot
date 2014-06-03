set xrange[150:3150]
unset key
set xlabel "Distance from transmitter (mm)"
set ylabel "RSS (dB)
set style line 1 linetype 1 linecolor rgb 'purple'
plot "../measurements/mpi_201403171057.log" u 1:3 ls 1

