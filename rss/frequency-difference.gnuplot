set style fill solid 0.25 border -1
set style boxplot outliers pointtype 7
set style data boxplot
set boxwidth  0.5
set pointsize 0.5

set xlabel "BLE channel"
set ylabel "RSS (dB)"
set yrange[-100:-50]

unset key
set style boxplot nooutliers sorted
plot "< grep ' ".(x." ".y." ".beacon eq "0 0 0x" ? "" : x." ".y." 3. ").beacon."' ../measurements/arch-sw02-offline.log" using (1):7:(0):5;
