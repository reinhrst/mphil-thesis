grepcmd(item) = "<grep -H '" . item ."' short-positioning-stats-0.1s.data short-positioning-stats-0.25s.data short-positioning-stats-0.5s.data short-positioning-stats-1.0s.data short-positioning-stats-1.5s.data short-positioning-stats-2.0s.data | sed -E 's/short-positioning-stats-([0-9.]+)s.data:/\\1 /'"


set xrange [0:2]
set yrange [0:3]
set ylabel "mean error (m)"
set xlabel "listening interval (s)"

plot grepcmd("SSD ")    u 1:7 with lp title "SSD", \
     grepcmd("SSD-O")   u 1:7 with lp title "SSD-O", \
     grepcmd("BRP ")    u 1:7 with lp title "BRP", \
     grepcmd("BRP-RPM") u 1:7 with lp title "BRP-RPM"
