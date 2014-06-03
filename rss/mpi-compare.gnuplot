set xrange[150:3150]
set yrange[-90:-30]

set tmargin 0
set bmargin 0
unset xlabel
set ylabel " "
set xtics ("" 500, "" 1000, "" 1500, "" 2000, "" 2500, "" 3000)
set ytics (-80, -60, -40)
set multiplot layout 5, 1
plot '../measurements/mpi_201403171057.log' u ($1/($2==37)):3 lc rgb 'purple' title 'channel 37 (run 1)'
set ylabel "RSS (dB)"
plot '../measurements/mpi_201403171159.log' u ($1/($2==37)):3 lc rgb 'purple' title 'channel 37 (run 2)'
set ylabel " "
plot '../measurements/mpi_201403171254.log' u ($1/($2==37)):3 lc rgb 'purple' title 'channel 37 (run 3)'
set xlabel "Distance from transmitter (mm)"
set xtics (500, 1000, 1500, 2000, 2500, 3000)
plot '../measurements/mpi_201403171254.log' u ($1/($2==38)):3 lc rgb 'purple' title 'channel 38 (run 3)'
