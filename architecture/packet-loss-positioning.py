from __future__ import print_function
import sys, hashlib
STEPS=range(1,11)
BEACONS = [1,2,5,10,15,20]

filename = sys.argv[1]

FREQ = 9.5

def default(d, k, v):
    if not d.has_key(k):
        d[k] = v
            
for i in STEPS:
    print("& %d"%i, end=" ")
print("\\\\ \\hline")
for b in BEACONS:
    tdb = {}
    db = {}

    starttime = None

    f = file(filename % b)
    for line in f:
        if line[0] == "#":
            continue
        parts = line.split()
        time = float(parts[0])
        if starttime == None:
            starttime = int(time+1)
        bucket = int((time-starttime)*FREQ)
        beacon = parts[3]
        for i in range(20):
            if bucket - i >=0:
                default(tdb,bucket-i,{})
                default(db,bucket-i,20)
                if not tdb[bucket-i].has_key(beacon):
                    tdb[bucket-i][beacon] = 1
                    if len(tdb[bucket-i]) == b:
                        db[bucket-i] = i

    print("%2d beacon"%b, end="")
    if b > 1:
        print("s", end=" ")
    else:
        print(" ", end=" ")

    buckets = sorted(db.keys())[:-20]
    mydb = [db[buck] for buck in buckets]
    for i in STEPS:
        rate = 100 - len(filter(lambda e: e < i, mydb)) / float(len(mydb))*100
        print("\\packetlosscell{",end="")
        if rate < 1:
            print("%4.02f" % rate , end="")
        elif rate < 10:
            print("%3.01f" % rate , end="")
        elif rate < 99.5:
            print("%2.0f" % rate , end="")
        else:
            print("100" , end="")
        print("\\%}",end=" ")
    print("\\\\ \\hline")
