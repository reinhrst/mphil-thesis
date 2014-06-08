from __future__ import print_function
import sys, os
BEACONS = range(1,21)
FREQ=9.5

filename = sys.argv[1]


for b in BEACONS:
    if os.path.exists(filename % b):
        f = file (filename % b)
        firsttimestamp = None
        lines = 0
        for line in f:
            parts = line.split()
            timestamp = float(parts[0])
            if firsttimestamp == None:
                firsttimestamp = timestamp
            lines += 1
        interval = timestamp - firsttimestamp
        print("%2d %.03f" % (b, (lines-1)/interval/(FREQ*b)))

