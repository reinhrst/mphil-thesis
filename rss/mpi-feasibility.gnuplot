system("make mpi-feasibility.data")
set xrange[150:3150]
set xlabel "Distance from transmitter (mm)"
set ylabel "RSS (dB)
unset colorbox
set palette defined (1 1 .6875 1, 2 1 0 0, 3 0 1 0)

plot "mpi-feasibility.data" lc palette notitle, \
 NaN w p lt 1 lc rgb '#FFB0FF'   t 'normal', \
 NaN w p lt 1 lc rgb 'red' t 'lateral shift', \
 NaN w p lt 1 lc rgb 'green'  t 'changed environment'
