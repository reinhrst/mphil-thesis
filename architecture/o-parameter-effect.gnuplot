set key bottom title 'Fingerprint based on angle' width -16 vertical maxrows 2
set yrange [0.7:1.3]
set ylabel "Median error (m)"
set xlabel "Pre-calculated fingerprint database resolution (\\textdegree)"
set xtics ("1" 0, \
           "2" 1, \
           "5" 2, \
           "10" 3, \
           "30" 4, \
           "60" 5, \
           "90" 6, \
           "120" 7, \
           "180" 8)

set ytics ( "0.8" 0.8, \
            "0.9" 0.9, \
            "1.0" 1.0, \
            "1.1" 1.1, \
            "1.2" 1.2, \
            "1.3" 1.3)

startx = .1314
starty = .2

set object 1 rectangle from screen startx-.01,starty to screen startx+.01,starty+.04 fillstyle noborder front fc rgb 'white'
set object 2 polygon from screen startx,starty-.01 \
                     to   screen startx,starty \
                     to   screen startx-.02,starty+.01 \
                     to   screen startx+.02,starty+.03 \
                     to   screen startx, starty+.04 \
                     to   screen startx, starty+.05 \
                     to   screen startx, starty+.04 \
                     to   screen startx+.02,starty+.03 \
                     to   screen startx-.02,starty+.01 \
                     to   screen startx,starty \
                     to   screen startx,starty-.01 \
    front


plot target u 0:1 w lp title "30\\textdegree", \
     ""     u 0:2 w lp title "45\\textdegree", \
     ""     u 0:3 w lp title "60\\textdegree", \
     ""     u 0:4 w lp title "75\\textdegree", \
     ""     u 0:5 w lp title "90\\textdegree", \
     ""     u 0:6 w lp title "120\\textdegree" lt 9, \
     ""     u 0:7 w lp title "180\\textdegree", \
     ""     u 0:8 w lp title "360\\textdegree", \

