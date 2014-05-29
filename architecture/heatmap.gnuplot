load 'drawsw02.gnuplot'
set cbrange[-85:-50]
set cblabel "RSS (dB)"
set palette defined (0 1 1 1, 0 0 0 0, 1 0 0 1, 5 1 0 0, 10 1 1 0)
do for [i=2:8] {
    set object i front
}
do for [i=50:53] {
    set object i front
}
unset key
set yrange [-26:1]
do for [i=30:33] {
    unset label i
    unset object i
}
do for [i=1:20] {
    if (i != heatmapbeacon) {
        unset label i
    }
}

eval(compass(2,-24,2))
beaconid = sprintf("0x%02x", heatmapbeacon)
plot '<grep '.beaconid.' fingerprint-database.data' u 1:(-$2):heatmapcolumn with image
