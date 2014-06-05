grepcmd(item) = "<grep -H '" . item ."' ". surveypointpartdeps ."| sed -E 's/positioning-stats-surveypointpart-([0-9.]+).data:/\\1 /'"


set xrange [0:226]
set yrange [0:10]
set ylabel "mean error (m)"
set xlabel "number of points surveyed"
set xtics (0,50,100,150,200,226)

plot grepcmd("SSD ")    u (floor($1*226)):7 with lp title "SSD", \
     grepcmd("SSD-O")   u (floor($1*226)):7 with lp title "SSD-O", \
     grepcmd("BRP ")    u (floor($1*226)):7 with lp title "BRP", \
     grepcmd("BRP-O")   u (floor($1*226)):7 with lp title "BRP-O", \
     grepcmd("BRP-RPM") u (floor($1*226)):(1.87) with lp title "BRP-RPM", \
     5.82                     with line lt 2 lc rgb 'black' title "Random"


