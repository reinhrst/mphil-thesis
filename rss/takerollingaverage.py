from __future__ import print_function
import sys, numpy

f = file(sys.argv[1])
beacon = sys.argv[2]
interval = int(sys.argv[3])

starttime = 0
elements = {37:[], 38:[], 39:[]}
def avg(s):
    if len(s) == 0:
        return 0
    return sum(s)/float(len(s))

for line in f:
    if line[0] == "#":
        continue
    parts = line.split()
    if starttime == 0:
        starttime = float(parts[0])
    id = parts[3]
    if not id == beacon:
        continue
    channel = int(parts[2])
    time = float(parts[0])-starttime
    rss = int(parts[4])
    elements[channel].append({"time": time, "rss": rss})

lines=[]
for t in range(0,int(time),interval):
    filtered = {c: filter(lambda e2: int(e2["time"]/interval) == int(t/interval), elements[c]) for c in elements}
    rsss = {c: [e["rss"] for e in filtered[c]] for c in filtered}
    stats = []
    for c in [37,38,39]:
        if len(rsss[c]) == 0:
            stats.append("0 - - - -")
        else:
            stats.append("%4d %4d %6.1f %6.1f %6.1f" %(len(rsss[c]), max(rsss[c]), numpy.median(rsss[c]), numpy.percentile(rsss[c],25), numpy.percentile(rsss[c], 75)))

    print("%5d %s" % (t, " ".join(stats)))

