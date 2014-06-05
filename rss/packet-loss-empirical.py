from __future__ import print_function
import sys, hashlib
STEPS=[1, 2, 4, 6, 8, 10, 13, 17, 20]
RUNS=20
BEACONS = [1,2,5,10,15,20]

f = open(sys.argv[1])

currentpos = None
firstsecond = True
lastsecond = None
packets = []

db = []

for line in f:
    if len(line.strip()) == 0 or line[0] == '#':
        continue
    parts = line.split()
    time = float(parts[0])
    second = int(time/2)
    channel = int(parts[4])
    beacon = parts[5]
    pos = map(int,parts[2:4])
    if(pos != currentpos):
        firstsecond=True
        lastsecond = second
        currentpos = pos
    if second != lastsecond:
        if firstsecond:
            firstsecond = False
        else:
            db.append(packets)
        packets = []
        lastsecond = second
    packets.append({"intervals": (time % 1)*20, "beacon": beacon, "channel":channel})

            
ALLBEACONS = ["0x%02x" % (i+1) for i in range(20)]

def hashme(v1):
    h = hashlib.md5()
    h.update(v1)
    return h.digest()

for i in STEPS:
    print("& %d"%i, end=" ")
print("\\\\ \\hline")
for b in BEACONS:
    print("%2d beacon"%b, end="")
    if b > 1:
        print("s", end=" ")
    else:
        print(" ", end=" ")
    for i in STEPS:
        allpacketsseen = 0
        for run in range(RUNS):
            interestedbeacons = set(sorted(ALLBEACONS, key=lambda beacon: hashme("%s %d"%(beacon,run)))[:b])
            for packets in db:
                interestedpackets = filter(lambda p: p["intervals"] < i and p["beacon"] in interestedbeacons, packets)
                beacons = set([p["beacon"] for p in interestedpackets])
                if len(beacons) == len(interestedbeacons):
                    allpacketsseen += 1
        rate = 100-float(allpacketsseen)/len(db*RUNS)*100
        print("\\packetlosscell{",end="")
        if rate < 1:
            print("%4.02f" % rate , end="")
        elif rate < 10:
            print("%3.01f" % rate , end="")
        elif rate < 99.5:
            print("%2.0f" % rate , end="")
        else:
            print(" 100" , end="")
        print("\\%}",end=" ")
    print("\\\\ \\hline")
