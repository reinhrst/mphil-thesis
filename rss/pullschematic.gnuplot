unset key
unset border
unset xtics
unset ytics
set xrange [.1:.9]
set yrange [0.1:0.35]
set size 1,.5


set label 1 'beacon' at 0.9,0.25 point lt 3 lc rgb 'red' ps 1.5
set label 2 'platform' at 0.65,0.18 center
set label 3 '1mm/s' at 0.65,0.32 
set arrow 3 from 0.64,0.32 rto -.05,0

set label 4 'pull motor' at 0.112,0.20 center
set label 5 'track' at 0.785,0.225 center


set object 1 rectangle from 0.2,0.245     to 0.87,0.255      fs empty border rgb 'black'
set object 2 rectangle from 0.6,0.3       to 0.7,0.2         fs solid border rgb 'black' fc rgb '#F0F0F0' 
set arrow  2           from 0.6,0.25     rto -0.47,0         nohead lc rgb 'blue'
set object 3 rectangle from 0.665,0.27    to 0.695,0.205     fs solid border rgb 'black' fc rgb 'black' 
set object 4 rectangle from 0.667,0.26    to 0.693,0.22      fs solid noborder fc rgb 'gray' 
set object 5 circle    at   0.68,0.2125   size 0.003         fs solid noborder fc rgb 'gray' 
set object 6 rectangle from 0.1,0.28      to 0.15,0.22       fs empty border rgb 'black'

set arrow 10       from 0.2,0.14  rto  0,.02  nohead lc rgb 'grey'
set arrow 11       from 0.2,0.15  rto  0.3,0  nohead lc rgb 'grey'
set label 12 '3 m' at 0.535,0.15 center
set arrow 12       from 0.87,0.15 rto -0.3,0  nohead lc rgb 'grey'
set arrow 13       from 0.87,0.14 rto  0,.02  nohead lc rgb 'grey'

plot NaN
