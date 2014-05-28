set angles degrees;
set polar;
set size square;
set rrange[-90:-50];
unset border;
unset xtics;
unset ytics;
if (source eq "grass") set key lmargin; else unset key;
set style line 1 linetype 1 linecolor rgb 'red' pointtype 1 pointsize 1;
set style line 2 linetype 1 linecolor rgb 'blue' pointtype 2 pointsize 1;
set style line 10 linetype 1 linewidth .5 linecolor rgb 'grey';
set grid polar 30 ls 10;
set label 1 "0\\textdegree" left at first 41, first 0
set label 2 "180\\textdegree" right at first -41, first 0
set label 3 "90\\textdegree" center at first 0, first 43
set label 4 "270\\textdegree" center at first 0, first -43
set label 5 "RSS (dB)" left at first 7, first 3
set rtics ("-90" -90, "" -80, "-70" -70, "" -60, "-50" -50)
plot '<awk -f rot-data.awk ../measurements/'.source.'-none.log' ls 1 title "without body", \
     '<awk -f rot-data.awk ../measurements/'.source.'-sitting.log' ls 2 title "with body"
