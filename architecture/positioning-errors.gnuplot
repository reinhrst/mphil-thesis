load 'drawsw02.gnuplot'
unset key

do for [i=2:8] {
    set object i front
}
do for [i=50:53] {
    set object i front
}
unset key
set yrange [-26:1]

set cbrange[0:3.5]
set cblabel "average positioning error (m)"
set palette defined (0 1 1 1, 0 0 0 0, 1 0 0 1, 5 1 0 0, 10 1 1 0)

plot '<python medianerror.py '.filename \
        using 1:(-$2):3     with image, \
     '' using 1:(-$2):4:(-$5) with vectors lt 1 lc rgb 'white', \
     '' using 1:(-$2):6:(-$7) with vectors lt 1 lc rgb 'white', \
     '' using 1:(-$2):8:(-$9) with vectors lt 1 lc rgb 'white'
