set yrange [23:40]
set xrange [0:20]
set ytics 25,5
unset key

startx = 1
dx = .5
starty = 23.5
dy = .8

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



set xrange [1:20]
set ylabel "Packet loss (\\%)"
set xlabel "Number of beacons"
target = '<python packet-loss-graph.py ../measurements/packet-loss/br-%dbeacon.log'
plot target u 1:(1-$2)*100 w lp
