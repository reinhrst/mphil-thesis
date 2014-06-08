set key bottom title 'Fingerprint based on angle' width -16 vertical maxrows 2
set xrange [0:8]
set ylabel "Median error (m)"
set xlabel "Pre-calculated fingerprint database resolution (\\textdegree)"
if (type eq "ssd") {
    set yrange [.75:1.3]
    set ytics ( "0.8" 0.8, \
                "0.9" 0.9, \
                "1.0" 1.0, \
                "1.1" 1.1, \
                "1.2" 1.2, \
                "1.3" 1.3)
    starty = .765
    dy = 0.02
} else {
    set yrange [.65:2.6]
    starty = .7
    dy = 0.06
}
set xtics ("1" 0, \
           "2" 1, \
           "5" 2, \
           "10" 3, \
           "30" 4, \
           "60" 5, \
           "90" 6, \
           "120" 7, \
           "180" 8)

startx = -0
dx = .15

set object 1 rectangle from startx-1,starty to startx+1,starty+dy fs solid noborder fc rgb 'white' front noclip

set object 2 polygon from startx,starty-.01 \
                     to   startx,starty \
                     to   startx-dx,starty+dy/4\
                     to   startx+dx,starty+3*dy/4 \
                     to   startx, starty+dy \
                     to   startx, starty+dy+.1 \
                     to   startx, starty+dy \
                     to   startx+dx,starty+3*dy/4 \
                     to   startx-dx,starty+dy/4 \
                     to   startx,starty \
                     to   startx,starty-.01 \
    front noclip


plot target u 0:1 w lp title "30\\textdegree", \
     ""     u 0:2 w lp title "45\\textdegree", \
     ""     u 0:3 w lp title "60\\textdegree", \
     ""     u 0:4 w lp title "75\\textdegree", \
     ""     u 0:5 w lp title "90\\textdegree", \
     ""     u 0:6 w lp title "120\\textdegree" lt 9, \
     ""     u 0:7 w lp title "180\\textdegree", \
     ""     u 0:8 w lp title "360\\textdegree", \

