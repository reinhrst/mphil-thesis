set xlabel "maximum RSS during positioning $p_i$ (dB)"
set ylabel "maximum RSS during surveying $s_i$ (dB)"
set xrange [-110:-40]
set yrange [-110:-40]
unset key

xdc(o) = -o*1.4/4
xc(o) = -104 + xdc(o)
yc(o) = xc(o)+1.5 + o

set label 1 "$s_i = p_i - 5$"  at xc(-5),yc(-5) left rotate by 34 front
set label 2 "$s_i = p_i$"      at xc(0),yc(0) left rotate by 34 front
set label 3 "$s_i = p_i + 5$"  at xc(5),yc(5) left rotate by 34 front
set label 4 "$s_i = p_i + 10$" at xc(10),yc(10) left rotate by 34 front
set label 5 "$s_i = p_i + 15$" at xc(15),yc(15) left rotate by 34 front


plot filename u ($1 == -105 ? -104.9 + rand(0)/5 : $1-.5+rand(0)):($2-.5+rand(0)) lt 2 ps 0.3 lc rgb 'purple', \
    x     lt 1 lc rgb 'black', \
    x - 5 lt 3 lc rgb 'black', \
    x + 5 lt 3 lc rgb 'black', \
    x + 10 lt 3 lc rgb 'black', \
    x + 15 lt 3 lc rgb 'black'
