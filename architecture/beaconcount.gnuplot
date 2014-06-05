grepcmd(item) = "<grep -H '" . item ."' ". beaconcountdeps ."| sed -E 's/positioning-stats-beaconcount-([0-9.]+).data:/\\1 /'"


set xrange [0:20]
set yrange [0:10]
set ylabel "mean error (m)"
set xlabel "number of active beacons"

plot grepcmd("SSD ")    u 1:7 with lp title "SSD", \
     grepcmd("SSD-O")   u 1:7 with lp title "SSD-O", \
     grepcmd("BRP ")    u 1:7 with lp title "BRP", \
     grepcmd("BRP-O")   u 1:7 with lp title "BRP-O", \
     grepcmd("BRP-RPM") u 1:7 with lp title "BRP-RPM", \
     5.82                     with line lt 2 lc rgb 'black' title "Random"

