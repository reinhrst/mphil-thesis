set xrange[150:3150]
set yrange[-90:-30]
set xlabel "Distance from transmitter (mm)"
set ylabel "RSS (dB)
set style line 1 linetype 1 linecolor rgb '#FFB0FF' pointtype 2 pointsize .7;
set style line 2 linetype 2 linecolor rgb 'black' linewidth 1;
set style line 12 linetype 2 linecolor rgb 'black' linewidth 4;
set style line 3 linetype 1 linecolor rgb 'red' linewidth 3;
set style line 4 linetype 1 linecolor rgb 'blue' linewidth 3;
set style line 5 linetype 1 linecolor rgb 'green' linewidth 3;

plot "../measurements/mpi_201403171057.log" u 1:3 ls 1 notitle, \
   -6*log(x)-11 ls 12 title 'ideal single RSS', \
   -6*log(x)-6+(log(average_length_mm)/log(10))**2/2 ls 12 notitle, \
    filename with l ls 3 title 'average', \
    "" using 1:($4) with l ls 4 title 'maximum', \
    "" using 1:5 with l ls 5 title 'median'
