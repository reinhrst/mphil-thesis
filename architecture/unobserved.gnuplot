target= 'short-walk-unobserved-beacons.data'
system("make " . target)
set nokey
set xrange [0:2]
set yrange [0:100]

set xlabel "Listening interval (s)"
set ylabel "Positionings at least one beacon missing (\\%)"

plot target u 1:($2/6.7) with line
