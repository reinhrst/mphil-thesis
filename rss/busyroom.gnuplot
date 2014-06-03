set key top

set ylabel "RSS (dB)"
set y2label "number of packets per second"
set xlabel "time (s)"

set yrange [-120:-60]
set y2range [0:10]
set y2tics

set style line  1 lt 1 lc rgb 'red'
set style line 11 lt 2 lc rgb 'red'
set style line  2 lt 1 lc rgb 'green'
set style line 12 lt 2 lc rgb 'green'
set style line  3 lt 1 lc rgb 'blue'
set style line 13 lt 2 lc rgb 'blue'

plot for [i=0:2] filename u 1:(column(i*5+6)              ) w l ls i+ 1 title sprintf("channel %2d", i+37), \
     for [i=0:2] filename u 1:(column(i*5+6)+column(i*5+7)) w l ls i+11 notitle, \
     for [i=0:2] filename u 1:(column(i*5+6)-column(i*5+7)) w l ls i+11 notitle, \
                 filename u 1:(($13+$8+$3)/100) w l ls 3 notitle axis x1y2, \
                 filename u 1:((    $8+$3)/100) w l ls 2 notitle axis x1y2, \
                 filename u 1:((       $3)/100) w l ls 1 notitle axis x1y2
