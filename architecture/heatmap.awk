{
    pos = $1 " " $2
    if ($3 == beacon) {
        db[pos] = $col
    }
}
END {
    for (y=0;y<=ymax;y++) {
        for (x=0;x<=xmax;x++) {
            pos = x " " y
            if (db[pos]) {
                print x,y,db[pos]
            } else {
                print x,y,-999
            }
        }
    }
}
