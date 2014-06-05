from __future__ import print_function
import sys, math, numpy

POS_HEIGHT=2
NO_DATA_HEADING=999
NO_DATA_RSS=-105
XMAX=29
YMAX=21
GRID_SIZE = 0.6

surveyfile = open(sys.argv[1])
beaconfile = open(sys.argv[2])
heading_widths = sys.argv[3]
if heading_widths == 'x':
    (HEADING_WIDTH_AVG,HEADING_WIDTH_MAX) = (0,0)
else:
    (HEADING_WIDTH_AVG,HEADING_WIDTH_MAX) = map(int,heading_widths.split("-"))

if len(sys.argv) > 4:
    LISTENING_LENGTH = float(sys.argv[4])
else:
    LISTENING_LENGTH = None


beacons = {}
data = {}

def heading_is_part_of_bucket(bucket_heading, heading, heading_width):
    if heading >= bucket_heading:
        if heading <= bucket_heading + heading_width/2:
            return True
        heading -= 360
    if heading < bucket_heading:
        if heading > bucket_heading - heading_width/2:
            return True
    heading += 360
    return heading <= bucket_heading + heading_width/2



for line in beaconfile:
    if line[0] == "#":
        continue
    if len(line.strip()) == 0:
        continue
    (id, x, y, z, R0) = line.split()
    beacons[id] = {"x": float(x), "y": float(y), "z": float(z), "R0": float(R0)}

for x in range(XMAX+1):
    for y in range(YMAX+1):
        pos = (x,y)
        data[pos] = {id: [] for id in beacons.keys()}

firsttime={}
for line in surveyfile:
    if line[0] == "#":
        continue
    parts = line.split()
    time = float(parts[0])
    pos = tuple(map(int,parts[2:4]))
    id = parts[5]
    rss = int(parts[6])
    heading = float(parts[7])
    if pos == (0,0):
        print (line)

    if LISTENING_LENGTH:
        if not firsttime.has_key(pos):
            firsttime[pos] = time + 0.3
        if time <= firsttime[pos] or time > firsttime[pos] + LISTENING_LENGTH:
            continue
    
    data[pos][id].append({"time": time, "rss": rss, "heading": heading})

print(" ".join([" x", " y","beacon", "   hdg", "  cnt", " max", "  mean", "   rpm"]), end="")
if HEADING_WIDTH_AVG > 0:
    print("".join([" %03davg %03dmax" % (d,d) for d in range(360)]))
else:
    print()

z = POS_HEIGHT
for y in range(YMAX+1):
    for x in range(XMAX+1):
        pos = (x,y)
        headings = reduce(lambda a,b: a+b, [[k["heading"] for k in data[pos][id]] for id in data[pos]])
        if len(headings) == 0:
            m_heading = NO_DATA_HEADING
            continue
        else:
            m_heading = 0
            headingcutoff = headings[0]
            headingsum = 0
            for h in headings:
                headingdiff = ((h - headingcutoff + 360 + 180) %360) - 180
                if headingdiff > 90 or headingdiff < -90:
                    m_heading = -1
                    break
                headingsum += headingdiff
            if m_heading != -1:
                m_heading = (headingsum/len(headings) + headings[0] + 360) % 360
            
        for id in beacons.keys():
            toprint = ["%2d"%x, "%2d"%y, "%5s"%id, "%6.01f"%m_heading, "%4d"%len(headings)]
            srss = sorted([e["rss"] for e in data[pos][id]])
            if len(srss):
                toprint.append("%4d" % srss[-1])
                toprint.append("%6.01f" % numpy.mean(srss))
                distance = (((x-beacons[id]["x"])**2 + (y-beacons[id]["y"])**2 + (z-beacons[id]["z"])**2)**.5) * GRID_SIZE
                toprint.append("%6.01f" % (beacons[id]["R0"]-20*math.log(distance)/math.log(10)))
            else:
                for i in range(4):
                    toprint.append("%4d" % NO_DATA_RSS)
            if HEADING_WIDTH_AVG > 0:
                for h in range(360):
                    rss_this_heading = filter(lambda k: heading_is_part_of_bucket(h, k["heading"], HEADING_WIDTH_AVG), data[pos][id])
                    if rss_this_heading:
                        toprint.append("%6.01f" % (sum([k["rss"] for k in rss_this_heading])/float(len(rss_this_heading))))
                    else:
                        toprint.append("%6.01f" % NO_DATA_RSS)
                    rss_this_heading = filter(lambda k: heading_is_part_of_bucket(h, k["heading"], HEADING_WIDTH_MAX), data[pos][id])
                    if rss_this_heading:
                        toprint.append("%6.01f" % (max([k["rss"] for k in rss_this_heading]),))
                    else:
                        toprint.append("%6.01f" % NO_DATA_RSS)
            print(" ".join(toprint))





        
