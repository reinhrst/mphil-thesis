target="positioning-heading-width-120-180.data"
system("make ".target)
points = system("wc -l ". target ."| grep -oE '[0-9]+'")

set key right bottom 
set yrange [0:1]
set xrange [0:8]

set xlabel "Error (m)"

min(a,b) = (a > b ? b : a)
error(x,y,x1,y1,x2,y2) = ((x-(x1+x2)/2)**2 + (y-(y1+y2)/2)**2)**.5

plot target u ( $5*.6):(1.0/points) s cumul t "Random", \
     ''     u ( $9*.6):(1.0/points) s cumul t "SSD", \
     ''     u ($13*.6):(1.0/points) s cumul t "SSD-O", \
     ''     u ($17*.6):(1.0/points) s cumul t "BRP", \
     ''     u ($21*.6):(1.0/points) s cumul t "BRP-O", \
     ''     u ($24*.6):(1.0/points) s cumul t "BRP-RPM"



