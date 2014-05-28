{
    pos= $3 "," $4;
    type=substr($7,3,1);
    id=substr($7 $8,5,10);
    rss=$10;
    if (type == 0) {
        if (!lastpos) {
            aposlength = 0;
        }
        if (lastpos != pos) {
            aposlength++;
            apos[aposlength] = pos;
            posmap[pos] = aposlength
            lastpos=pos
        }
        mr = maxrss[aposlength "_" id]
        maxrss[aposlength "_" id] = (mr && mr > rss ? mr : rss)
    }
}
END {
    printf ("%2s %2s ", "x", "y")
    for (i=1;i<=20;i++) {
        id = sprintf ("fafafa00%02x", i)
        printf ("%10s ", id)
    }
    print ""
    for (x=0; x<30; x++) {
        for (y=0; y<22; y++) {
            pos=x "," y
            if ((p=posmap[pos]) || fill) {
                printf ("%2d %2d ", x, y)
                for (i=1;i<=20;i++) {
                    id = sprintf ("fafafa00%02x", i)
                    mr = maxrss[p "_" id] 
                    if (!mr) {
                        mr=-999
                    }
                    printf ("%10d ", mr)
                }
                print ""
            }
        }
    }
}
