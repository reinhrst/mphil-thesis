set yrange [0:1.1]
set xrange [0:82]
set tic scale 0

set macros
ticstring = '('
do for [c=0:39] {
    channel = (c==0 ? 37 : c==12 ? 38 : c == 39 ? 39 : c < 12 ? c-1 : c-2)
        ticstring=  ticstring.\
                    '"\\textsf{\\tiny{'.(2402+c*2).'MHz, channel '.(channel < 10 ? '0' : '').channel.'}}" '.\
                    (c*2+2).', '
}
ticstring = ticstring.'"" 20000) rotate by 90 right'
set xtics @ticstring

unset ytics
unset key
set sample 10000
plot for [c=0:39] \
    f(x) = (1-((x-2-2*c)/.8)**2) \
    (f(x) > 0) ? sqrt(f(x)) : 0 \
    with filledcurves above y1=0 lw 0 lc rgb (c == 0 || c == 12 || c==39) ? '#A0A0FF' : '#FFA0A0';
