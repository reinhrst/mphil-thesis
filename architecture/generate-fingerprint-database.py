from __future__ import print_function
import sys, math

POS_HEIGHT=2
HEADING_INTERVAL=5
HEADING_WIDTH=60
NO_DATA_RSS=-999
XMAX=29
YMAX=21
GRID_SIZE = 0.6

surveyfile = open(sys.argv[1])
beaconfile = open(sys.argv[2])

beacons = {}
data = {}

def heading_is_part_of_bucket(bucket_heading, heading):
    if heading >= bucket_heading:
        if heading <= bucket_heading + HEADING_WIDTH/2:
            return True
        heading -= 360
    if heading < bucket_heading:
        if heading > bucket_heading - HEADING_WIDTH/2:
            return True
    heading += 360
    return heading <= bucket_heading + HEADING_WIDTH/2



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

for line in surveyfile:
    if line[0] == "#":
        continue
    (time, timediff, x, y, channel, id, rss, heading) = line.split()
    pos = (int(x), int(y))
    if pos == (0,0):
        print (line)
    data[pos][id].append({"rss": int(rss), "heading": float(heading)})

print(" ".join([" x", " y","beacon", "   hdg", " max", " 99th", "  mean", "   rpm"] + ["%03ddeg" % (d*HEADING_INTERVAL) for d in range(360/HEADING_INTERVAL)]))
z = POS_HEIGHT
for y in range(YMAX+1):
    for x in range(XMAX+1):
        pos = (x,y)
        headings = reduce(lambda a,b: a+b, [[k["heading"] for k in data[pos][id]] for id in data[pos]])
        if len(headings) == 0:
            m_heading = NO_DATA_RSS
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
            toprint = ["%2d"%x, "%2d"%y, "%5s"%id, "%6.01f"%m_heading]
            byrss = sorted(data[pos][id], key=lambda k: k["rss"])
            if len(byrss):
                toprint.append("%4d" % byrss[len(byrss)-1]["rss"])
                toprint.append("%4d" % byrss[len(byrss)*99/100]["rss"])
                toprint.append("%6.01f" % (sum([k["rss"] for k in byrss])/float(len(byrss))))
                distance = (((x-beacons[id]["x"])**2 + (y-beacons[id]["y"])**2 + (z-beacons[id]["z"])**2)**.5) * GRID_SIZE
                toprint.append("%6.01f" % (beacons[id]["R0"]-20*math.log(distance)/math.log(10)))
            else:
                for i in range(4):
                    toprint.append("%4d" % NO_DATA_RSS)
            for h in range(360/HEADING_INTERVAL):
                heading = h * HEADING_INTERVAL
                rss_this_heading = filter(lambda k: heading_is_part_of_bucket(heading, k["heading"]), byrss)
                if rss_this_heading:
                    toprint.append("%6.01f" % (sum([k["rss"] for k in rss_this_heading])/float(len(rss_this_heading))))
                else:
                    toprint.append("%6.01f" % NO_DATA_RSS)
            print(" ".join(toprint))





        
