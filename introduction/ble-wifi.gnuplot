set size 1.1,.6
set yrange [0:1.1]
set xrange [2400.5:2481.5]
set tic scale 0
set ytics ("\\textsf{\\tiny{BLE channel}}" 0.05, "\\textsf{\\tiny{\\Wifi channel}}" 1.05)
set lmargin 8
set bmargin 4
set xtics rotate 2,2 format "\\textsf{\\tiny{%.0f MHz}}"
unset key
set sample 2000
do for [c=0:39] {
    set label c+1 at c*2+2402,.05 center sprintf((c==0 || c == 12 || c == 39) ? "\\textsf{\\tiny{\\textbf{%d}}}" : "\\textsf{\\tiny{%d}}",(c==0 ? 37 : c==12 ? 38 : c == 39 ? 39 : c < 12 ? c-1 : c-2) ) front
    set object c+1 rect from c*2+2401.2,0.07 to c*2+2402.8,.01 fc rgb "white" front fs solid 0 noborder
}
do for [c=0:12] {
    set label c+41 at c*5+2412,1.05 center sprintf((c%5) == 0 ? "\\textsf{\\tiny{\\textbf{%d}}}" : "\\textsf{\\tiny{%d}}",c+1) front
}
plot for [c=0:39] f(x) = (1-((x-2*c-2402)/.9)**2) (f(x) > 0) ? sqrt(f(x)) : 0 with filledcurves above y1=0 lw 0 lc rgb (c == 0 || c == 12 || c==39) ? '#A0A0FF' : '#FFA0A0', \
for [c=0:13] f(x) = (1-((x-5*c-2412-7*(c==13))/10)**2) f(x) > 0 ? sqrt(f(x)) : 0 lw ((c%5) ? 1 : 5) lt ((c%5) ? 4 : 1) lc rgb "black"
