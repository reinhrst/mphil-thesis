from __future__ import print_function
import sys, numpy

GRID_SIZE=0.6

files = map(file, sys.argv[1:])

XMAX=29
YMAX=21

data = {(x,y): [] for x in range(XMAX+1) for y in range(YMAX+1)}
for f in files:
    for line in f:
        if len(line.strip()) == 0 or line[0] == '#':
            continue
        parts = line.split()
        pos = tuple(map(int, parts[:2]))
        (x,y) = map(float,parts[2:4])
        distance = float(parts[4])
        penalty = float(parts[5])
        data[pos].append({"x":x, "y":y, "distance":distance, "penalty":penalty})

def avg(x):
    return sum(x)/float(len(x))

def getarrowcoord(x,y,dx,dy):
    if x == dx and y == dy:
        return (0,0)
    dist = ((x-dx)**2+(y-dy)**2)**.5
    return ((dx-x)/dist/2, (dy-y)/dist/2)


for y in range(YMAX+1):
    for x in range(XMAX+1):
        pos = (x,y)
        print("%2d %2d"% pos, end=" ")
        if len(data[pos]) == 0:
            print("-1")
            continue
        print("%5.2f" %(avg([d["distance"] for d in data[pos]])*GRID_SIZE), end=" ")
        print(" ".join(["%4.1f %4.1f"%getarrowcoord(x,y,d["x"],d["y"]) for d in data[pos]]))

