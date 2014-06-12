set xrange [0:5]
set yrange [0:3.5]
unset border
unset ytics
unset xtics
unset key
set size ratio -1

set arrow 1 from 0  ,0   rto 3.6 ,0   nohead
set arrow 2 from 4.5,0   rto 0   ,3.5 nohead
set arrow 3 from 0  ,0   rto 0   ,3.5 nohead
set arrow 4 from 0  ,3.5 rto 4.5 ,0   nohead
set arrow 5 from 4.5,0   rto -.1 ,0   nohead
set arrow 6 from 4.4,0   rto -.4,.4*(3**.5)   nohead

set object 1 polygon from 0,3.5 rto 1.5,0 rto 0,-.7 rto -1.5,0 rto 0,.7 fs solid border rgb 'black' fc rgb 'grey'
set object 2 polygon from 1.5,3.5 rto 1.5,0 rto 0,-.7 rto -1.5,0 rto 0,.7 fs solid border rgb 'black' fc rgb 'grey'
set object 3 polygon from 3,3.5 rto 1.5,0 rto 0,-.7 rto -1.5,0 rto 0,.7 fs solid border rgb 'black' fc rgb 'grey'

set object 10 polygon from 3.8,2.5 rto 0,-1.5 rto .7,0 rto 0,1.5 rto -.7,0 fs solid border rgb 'black' fc rgb 'grey'
set object 11 polygon from 0,2 rto .5,0 rto 0,-.5 rto -.5,0 rto 0,.5 fs solid border rgb 'black' fc rgb 'grey'

set pointsize 1.8
set label 1 'beacon 1, ceiling'  at 4.45,0.20 front point lt 3 lc rgb 'red'
set label 3 'beacon 3, floor'    at 4.45,0.05 front point lt 3 lc rgb 'red'
set label 2 'beacon 2, ceiling'  at 4.45,3.30 front point lt 3 lc rgb 'red'
set label 4 'beacon 4, floor'    at 4.45,3.45 front point lt 3 lc rgb 'red'

set label 5 'beacon 5, on table' at 4.45,1.75 front point lt 3 lc rgb 'red'
set label 6 'beacon 6, on table' at 0.45,1.75 front point lt 3 lc rgb 'red'


set object 20 rectangle from 3.85,1.6 rto .05,.3 fs solid noborder fc rgb 'black'
set label 20 'iPad mini on table' at 2.77,1.1 front
set arrow 20 from 3.7,1.25 rto .13,.3 head lc rgb 'black'

plot NaN
