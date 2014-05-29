set xrange[-1:33]
set yrange[-26:1]
set size ratio -1

set object 2 polygon from \
    24.0,  - 1.0 to \
    25.2,  - 1.0 to \
    25.2,  - 0.0 to \
    24.0,  - 0.0 to \
    24.0,  - 1.0 \
    behind \
    fillstyle solid \
    fillcolor rgb '#DDDDDD' 
set object 3 polygon from \
    19.5,  -11.0 to \
    20.0,  -10.5 to \
    20.5,  -11.0 to \
    20.0,  -11.5 to \
    19.5,  -11.0 \
    behind \
    fillstyle solid \
    fillcolor rgb '#DDDDDD' 
set object 4 polygon from \
    29.2,  -10.0 to \
    28.0,  -10.0 to \
    28.0,  -13.0 to \
    29.2,  -13.0 to \
    29.2,  -10.0 \
    behind \
    fillstyle solid \
    fillcolor rgb '#DDDDDD' 
set object 5 polygon from \
    17.4,  -21.2 to \
    17.4,  -20.0 to \
    19.4,  -20.0 to \
    19.4,  -21.2 to \
    17.4,  -21.2 \
    behind \
    fillstyle solid \
    fillcolor rgb '#DDDDDD' 
set object 6 polygon from \
     4.0,  - 8.1 to \
     9.2,  - 8.1 to \
     9.2,  - 6.9 to \
     4.0,  - 6.9 to \
     4.0,  - 8.1 \
    behind \
    fillstyle solid \
    fillcolor rgb '#DDDDDD' 
set object 7 polygon from \
    -0.2,  - 1.8 to \
    -0.2,  - 6.6 to \
     1.5,  - 6.6 to \
     1.5,  - 1.8 to \
    -0.2,  - 1.8 \
    behind \
    fillstyle solid \
    fillcolor rgb '#DDDDDD'

set object 8 polygon from \
    -0.2,  - 1.8 to \
    -0.2,  - 8.1 to \
     9.2,  - 8.1 to \
     9.2,  - 5.5 to \
     9.8,  - 5.5 to \
     9.8,  -17.9 to \
     9.2,  -17.9 to \
     9.2,  -17.8 to \
     5.8,  -17.8 to \
     5.8,  -21.2 to \
     9.2,  -21.2 to \
     9.2,  -20.4 to \
     9.8,  -20.4 to \
     9.8,  -21.2 to \
    29.2,  -21.2 to \
    29.2,  - 1.8 to \
    28.0,  - 1.8 to \
    28.0,    0.0 to \
    23.5,    0.5 to \
    23.5,  - 1.8 to \
    18.0,  - 1.8 to \
    18.0,    0.0 to \
    13.5,    0.5 to \
    13.5,  - 1.8 to \
     9.8,  - 1.8 to \
     9.8,  - 2.6 to \
     9.2,  - 2.6 to \
     9.2,  - 1.8 to \
     8.0,  - 1.8 to \
     8.0,    0.0 to \
     3.5,    0.5 to \
     3.5,  - 1.8 to \
    -0.2,  - 1.8

computer_table_s="nr=%d;x=%d;y=%d;oscale=3;iscale=1;set object nr polygon from "
do for [r=0:10] {
    computer_table_s = computer_table_s . sprintf("sin(%d*pi/5.0)*oscale+x, cos(%d*pi/5.0)*oscale+y to ", r, r)
}
do for [r=0:10] {
    computer_table_s = computer_table_s . sprintf("sin(%d*pi/5.0)*iscale+x, cos(%d*pi/5.0)*iscale+y to ", -r, -r)
}
computer_table_s = computer_table_s . sprintf("sin(%d*pi/5.0)*oscale+x, cos(%d*pi/5.0)*oscale+y", 0, 0)
computer_table_s = computer_table_s . " behind fillstyle solid fillcolor rgb '#DDDDDD'"

computer_table(x,y,nr) = sprintf(computer_table_s, nr, x, y)
eval(computer_table(15.0,- 6,50))
eval(computer_table(15.0,-16,51))
eval(computer_table(24.2,- 6,52))
eval(computer_table(24.2,-16,53))


set object 30 circle center  8 +  5.0/60,-23 size  5.0/60 fs empty border lc rgb 'red'
set object 31 circle center  8 + 10.0/60,-25 size 10.0/60 fs empty border lc rgb 'red'
set object 32 circle center 13 + 20.0/60,-23 size 20.0/60 fs empty border lc rgb 'red'
set object 33 circle center 13 + 50.0/60,-25 size 50.0/60 fs empty border lc rgb 'red'

set label 30 'error 50cm'  at first  7.6, first -23.05 right
set label 31 'error 100cm' at first  7.6, first -25.05 right
set label 32 'error 200cm' at first 12.6, first -23.05 right
set label 33 'error 500cm' at first 12.6, first -25.05 right

set pointsize 1.8
beacon(x,y,nr,lt) = sprintf("x=%f;y=%f;nr=%d; set label nr '' at first x, first y front point lt %d lc rgb 'red'", x, y, nr, lt)
#wall mounted beacons
eval(beacon( 5.8,-20.5,0x03,3))
eval(beacon( 9.8,-17.0,0x13,3))
eval(beacon(12.8,-21.2,0x0b,3))
eval(beacon(22.2,-21.2,0x06,3))
eval(beacon(29.2,-16.5,0x02,3))
eval(beacon(29.2,- 5.6,0x04,3))
eval(beacon(23.5,- 0.8,0x0d,3))
eval(beacon(18.0,- 0.5,0x0a,3))
eval(beacon( 3.5,- 0.7,0x11,3))
eval(beacon( 0.7,- 8.1,0x10,3))


#table mounted beacons
eval(beacon(23.5,-17.0,0x07,3))
eval(beacon(25.2,-15.1,0x12,3))

eval(beacon(24.7,- 7.0,0x05,3))
eval(beacon(23.2,- 5.1,0x0c,3))

eval(beacon(15.8,- 4.9,0x09,3))
eval(beacon(13.9,- 6.5,0x0e,3))

eval(beacon(15.8,-16.8,0x08,3))
eval(beacon(14.2,-15.2,0x14,3))

eval(beacon(20.0,-11.0,0x0f,3))
eval(beacon(18.0,-26.0,0x01,3))

compass(x,y,size)=sprintf("x=%f;y=%f;size=%f;",x,y,size) . "set object 100 circle at x,y size size fs empty border lc rgb 'black'; set angles degrees; north=70; set arrow 100 from x-size*sin(north),y-size*cos(north) to x+size*sin(north),y+size*cos(north); set label 100 'N' at x+(size+.5)*sin(north),y+(size+.5)*cos(north)"

set grid
set key left bottom
set xtics scale 0
set ytics scale 0
unset xtics
unset ytics
unset border

