grepcmd(item) = "<grep -H '" . item ."' ". livebeaconcountdeps ."| sed -E 's/positioning-stats-livebeaconcount-([0-9.]+).data:/\\1 /'"


set xrange [0:20]
set yrange [0:10]
set ylabel "mean error (m)"
set xlabel "number of unobserved beacons (out of 20)"
set xtics ("20" 0, "15" 5, "10" 10, "5" 15, "0" 20)

plot grepcmd("SSD ")    u 1:7 with lp title "SSD", \
     grepcmd("SSD-O")   u 1:7 with lp title "SSD-O", \
     grepcmd("BRP ")    u 1:7 with lp title "BRP", \
     grepcmd("BRP-O")   u 1:7 with lp title "BRP-O", \
     grepcmd("BRP-RPM") u 1:7 with lp title "BRP-RPM", \
     5.82                     with line lt 2 lc rgb 'black' title "Random"


