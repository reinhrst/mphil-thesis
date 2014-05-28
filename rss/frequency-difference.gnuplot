set style fill solid 0.25 border -1
set style boxplot outliers pointtype 7
set style data boxplot
set boxwidth  0.5
set pointsize 0.5

set yrange [-70:-58]
set xlabel "BLE channel"
set ylabel "RSS (dB)"

unset key
set style boxplot sorted
plot "<awk '/0a000101 05010044 44550003/ { \
    channel=$3; \
    rss=$8; \
    rotation=$9; \
    if (rss!=127 && rotation > 190 && rotation < 210) \
    { \
        print channel, rss; \
    } \
    }' ../measurements/grass-none.log" \
    using (1):2:(0):1;
