load 'drawsw02.gnuplot'
set key left bottom height 1.1 box
do for [i=30:33] {
    unset label i
    unset object i
}

eval(compass(32,-26,2))

set yrange [-28:2]
set xrange [-1:35]
set object 101 polygon from -.2,2 to -.2,1 to -.2,1.5 to 12,1.5 to -.2,1.5 to -.2,2 fs empty border lc rgb '#DDDDDD'
set object 102 polygon from 29.2,2 to 29.2,1 to 29.2,1.5 to 17,1.5 to 29.2,1.5 to 29.2,2 fs empty border lc rgb '#DDDDDD'
set label 101 '17.6 m' at 14.5,1.5 center

set object 103 polygon from 35,.5 to 33,.5 to 34,.5 to 34,-8.35 to 34,.5 to 35,.5 fs empty border lc rgb '#DDDDDD'
set object 104 polygon from 35,-21.2 to 33,-21.2 to 34,-21.2 to 34,-13.35 to 34,-21.2 to 35,-21.2 fs empty border lc rgb '#DDDDDD'
set label 103 '13.0 m' at 34,-10.85 center rotate by -90

plot '<echo "1000 1000"' lt 3 lc rgb 'red' title "BLE beacon"
