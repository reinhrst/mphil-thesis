set xrange[150:3150]
set yrange[-90:-30]
set xlabel "Distance from transmitter (mm)"
set ylabel "RSS (dB)
unset colorbox
set palette defined (37 1 0 0, 38 0 1 0, 39 0 0 1)

plot "../measurements/mpi_201403171057.log" u 1:3:2 lc palette notitle, \
 NaN w p lt 1 lc rgb 'red'   t 'channel 37', \
 NaN w p lt 1 lc rgb 'green' t 'channel 38', \
 NaN w p lt 1 lc rgb 'blue'  t 'channel 39'
