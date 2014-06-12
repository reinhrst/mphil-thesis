set key top horizontal width 1.5

y1min=-90
y1max=-43
p0=0
p1=1100
p2=2750
p3=3800
p4=4000
p5=4300

ly1 = -55
ptop = 13.7
pbottom = -.2
pbottom2 = -1.8

STARTTIME=1400843242+2000

ft(p) = sprintf("%2d:%02d", (p+STARTTIME+30)/3600%24+1, (p+STARTTIME+30)/60%60)

set ylabel "RSS (dB)"

set xrange [p0:p5]
set yrange [y1min:y1max]
set ytics -85,5

bin(x,y) = floor(x/y)*y
unset colorbox
unset xlabel

set tmargin 2
set bmargin 0

set lmargin 6
set rmargin 3

set label 1 "\\huge{1}"  at (p0+p1)/2,ly1 center
set label 2 "\\huge{2}"  at (p1+p2)/2,ly1 center
set label 3 "\\huge{3}"  at (p2+p3)/2,ly1 center
set label 4 "\\large{4}" at (p3+p4)/2,ly1 center
set label 5 "\\huge{5}"  at (p4+p5)/2,ly1 center

set palette defined (37 1 0 0, 38 0 1 0, 39 0 0 1)
set multiplot layout 2,1
unset xtics

plot \
 filename u ($1-STARTTIME):5:3 w p ls 1 lc palette notitle, \
 NaN with boxes fs solid border -1 ls 1 lc rgb 'red'   t 'ch. 37', \
 NaN with boxes fs solid border -1 ls 1 lc rgb 'green' t 'ch. 38', \
 NaN with boxes fs solid border -1 ls 1 lc rgb 'blue'  t 'ch. 39'

y1min=0

set arrow 1 from p1,y1min to p1,ptop lt 2 lc rgb 'black' nohead front
set arrow 2 from p2,y1min to p2,ptop lt 2 lc rgb 'black' nohead front
set arrow 3 from p3,y1min to p3,ptop lt 2 lc rgb 'black' nohead front
set arrow 4 from p4,y1min to p4,ptop lt 2 lc rgb 'black' nohead front


set arrow 10 from p0,pbottom  to p0,y1min lt 1 lc rgb 'black' nohead back
set arrow 11 from p1,pbottom  to p1,y1min lt 1 lc rgb 'black' nohead back
set arrow 12 from p2,pbottom  to p2,y1min lt 1 lc rgb 'black' nohead back
set arrow 13 from p3,pbottom  to p3,y1min lt 1 lc rgb 'black' nohead back
set arrow 14 from p4,pbottom  to p4,y1min lt 1 lc rgb 'black' nohead back
set arrow 15 from p5,pbottom  to p5,y1min lt 1 lc rgb 'black' nohead back

set label 14 ft(p4) at p4,pbottom2 center

unset label 1
unset label 2
unset label 3
unset label 4
unset label 5

set ytics 0,1,6
set tmargin 0
set bmargin 3
set xlabel "time"
set xtics ( ft(p0) p0, ft(p1) p1, ft(p2) p2, ft(p3) p3-100, ft(p5) p5 ) nomirror
set yrange[0:7]
set ylabel "packets per second"
plot \
 filename u (bin($1-STARTTIME,60)):(1.0/60 * ($3 < 40)) s freq with boxes fs solid border -1 ls 1 lc rgb 'blue'  notitle, \
 filename u (bin($1-STARTTIME,60)):(1.0/60 * ($3 < 39)) s freq with boxes fs solid border -1 ls 1 lc rgb 'green' notitle, \
 filename u (bin($1-STARTTIME,60)):(1.0/60 * ($3 < 38)) s freq with boxes fs solid border -1 ls 1 lc rgb 'red'   notitle, \



