points = system("wc -l ". target ."| grep -oE '[0-9]+'")

set key right bottom title "Compass error"
set yrange [0:1]
set xrange [0:6]

set xlabel "Error (m)"

plot target u ($5*.6):(1.0/points) s cumul lc rgb 'grey' lw 5 t type, \
    for [i=0:6] '' u (column(i*12+9)*.6):(1.0/points) s cumul t sprintf("%d\\textdegree",i*30)


