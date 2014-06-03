load 'drawsw02.gnuplot'
unset key

basecol = (plottype eq "Random" ? 1 : plottype eq "SSD" ? 2 : plottype eq "SSD-O" ? 3 : plottype eq "BRP" ? 4 : plottype eq "BRP-RPM" ? 5: -100)*4-1

xcol    = basecol
ycol    = basecol+1
distcol = basecol+2
penalty = basecol+3

set yrange[-22:2]
unset label 1

set palette defined (0 0.9 0.9 0.9, 1 0 0 0)
unset colorbox

plot 'positioning-heading-width-120.data' \
        using 1:(-$2):(column(distcol)/10):(column(penalty))     with circles lt 1 lc palette, \
     '' using 1:(-$2):(column(xcol)-$1)/10:(-column(ycol)+$2)/10 with vectors lt 1 lc rgb 'blue'
