from __future__ import print_function
import sys, numpy

f = file(sys.argv[1])
beacon = sys.argv[2]
interval = float(sys.argv[3])

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
for c in elements:
    for e in elements[c]:
        t = e["time"]
        rss = e["rss"]
        filtered = {c: filter(lambda e: abs(e["time"] - t) < interval/2, elements[c]) for c in elements}
        rsss = {c: [e["rss"] for e in filtered[c]] for c in filtered}
        counts = {c: len(filter(lambda e2: int(e2["time"]/100) == int(t/100), elements[c])) for c in elements}
        lines.append({"time":t, "line":("%10.5f %4d" + (" %5d %4d %6.1f %7.2f %7.2f"* 3)) % tuple([t, rss] +
                sum ([[counts[c], max(rsss[c]), numpy.median(rsss[c]), avg(rsss[c]), numpy.std(rsss[c])] for c in [37,38,39]], []))})

for line in sorted(lines, key=lambda l: l["time"]):
    print(line["line"])
