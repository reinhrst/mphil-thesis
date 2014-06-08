set xrange[-20:5]
set yrange[0:5]
set samples 20000
set xlabel "$p_i - s_i$"
set ylabel "punishment"
set key top
plot (x < -10 ? abs(x) * 0.1 : x < 0 ? abs(x+4.2)*0.01 : x < 4 ? x+0.042 : 3.042+x*100000) title "\\aBRP", \
    (x+4.2)**2/30 title "Euclidean distance"
