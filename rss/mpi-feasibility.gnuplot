system("make mpi-feasibility.data")
set xrange[150:3150]
set xlabel "Distance from transmitter (mm)"
set ylabel "RSS (dB)
set style line 1 linetype 1 linecolor rgb '#FFDDFF' pointtype 1 pointsize .7;
set style line 2 linetype 1 linecolor rgb 'red' pointtype 1 pointsize .5;
set style line 3 linetype 1 linecolor rgb 'blue' pointtype 1 pointsize .5;
unset colorbox
set palette defined (37 1 .87 1, 38 1 0 0, 39 0 0 1)

plot "mpi-feasibility.data" lc palette notitle, \
 NaN w p lt 1 lc rgb '#FFDDFF'   t 'normal', \
 NaN w p lt 1 lc rgb 'red' t 'lateral shift', \
 NaN w p lt 1 lc rgb 'blue'  t 'changed environment'
