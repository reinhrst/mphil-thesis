grepcmd(item) = "<grep -H '" . item ."' ".shortwalkdeps." | sed -E 's/short-positioning-stats-([0-9.]+)s.data:/\\1 /'"


set xrange [0:2]
set yrange [0:10]
set ylabel "mean error (m)"
set xlabel "listening interval (s)"

plot grepcmd("SSD ")    u 1:7 with lp lw 2 title "SSD", \
     grepcmd("SSD-O")   u 1:7 with lp lw 2 title "SSD-O", \
     grepcmd("BRP ")    u 1:7 with lp lw 2 title "BRP", \
     grepcmd("BRP-O ")  u 1:7 with lp lw 2 title "BRP-O", \
     grepcmd("BRP-RPM") u 1:7 with lp lw 2 title "BRP-RPM", \
     5.82                     with line lt 2 lc rgb 'black' title "Random"
