from __future__ import print_function
import sys, math, hashlib, os

HEADING_INTERVAL=1
BRP_HIGH_PENALTY_CUTOFF= 3
BRP_HIGH_PENALTY_FACTOR= 100000
BRP_LOW_PENALTY_FACTOR = .125
K = 5
GRID_SIZE=0.60

if os.environ.has_key("BEACONCOUNT"):
    BEACONCOUNT = int(os.environ["BEACONCOUNT"])
else:
    BEACONCOUNT = 20

if os.environ.has_key("LIVEBEACONCOUNT"):
    LIVEBEACONCOUNT = int(os.environ["LIVEBEACONCOUNT"])
else:
    LIVEBEACONCOUNT = 20

if os.environ.has_key("RUNS"):
    RUNS = int(os.environ["RUNS"])
else:
    RUNS = 1

if os.environ.has_key("SURVEYPOINTPART"):
    SURVEYPOINTPART = float(os.environ["SURVEYPOINTPART"])
else:
    SURVEYPOINTPART = 1


METHODS=sys.argv[1].split()
database = file(sys.argv[2])
walks = map(file, sys.argv[3:])

fingerprints = None


MAX=0
NNTH=1
MEAN=2
RPM=3
HEADING_BASE=4

EPSILON = 0.01

def avg(seq):
    return sum(seq)/float(len(seq))

def percentile(seq, pct):
    return sorted(seq)[min(len(seq) * pct / 100, len(seq)-1)]

def calc_BRP(measurementRSS, fingerprintRSS):
    diff = measurementRSS - fingerprintRSS
    if diff > BRP_HIGH_PENALTY_CUTOFF:
        return diff+BRP_HIGH_PENALTY_FACTOR
    if diff >= 0:
        return diff
    if diff > -10:
        return -diff*0.001
    return -diff*BRP_LOW_PENALTY_FACTOR


def calc_penalties(positioning, candidate_position):
    "Calculates penalties for all methods, to place this positioning measurement at the candidate position"
    fingerprint = fingerprints[candidate_position]
    result = {}
    for method in METHODS:
        if method=="Random":
            h = hashlib.md5();
            h.update(repr((candidate_position,"".join(["%f"%positioning[id][MEAN] for id in fingerprint]))))
            result['Random'] = int(h.hexdigest()[:6],16)+EPSILON
        if method=="SSD":
            result['SSD'] = sum([(positioning[id][MEAN]-fingerprint[id][       MEAN])**2 for id in fingerprint])**.5 + EPSILON
        if method=="BRP":
            result['BRP'] = sum([calc_BRP(positioning[id][MAX],fingerprint[id][MAX]) for id in fingerprint]) + EPSILON
        if method=="BRP-RPM":
            result['BRP-RPM'] = sum([calc_BRP(positioning[id][MAX],fingerprint[id][RPM]) for id in fingerprint]) + EPSILON
        if method[:len("SSD-C")] == "SSD-C":
            compass_error = int(method[len("SSD-C"):])
            interval = 1
            heading_col = HEADING_BASE + int((positioning["heading"]+compass_error+interval/2)%360)/interval*interval/HEADING_INTERVAL
            result[method] = sum([(positioning[id][MEAN]-fingerprint[id][heading_col])**2 for id in fingerprint])**.5 + EPSILON
        if method[:len("SSD-O")] == "SSD-O":
            interval = method[len("SSD-O"):]
            if len(interval) == 0:
                interval = "1"
            interval = int(interval)
            heading_col = HEADING_BASE + int((positioning["heading"]+interval/2)%360)/interval*interval/HEADING_INTERVAL
            result[method] = sum([(positioning[id][MEAN]-fingerprint[id][heading_col])**2 for id in fingerprint])**.5 + EPSILON
    return result

def hashme(v1, v2, v3):
    h = hashlib.md5()
    h.update(repr(v1))
    h.update(repr(v2))
    h.update(repr(v3))
    return h.digest()

def WKNN(penalties, method, pos, k):
    ordered = sorted(penalties, key=lambda p: p["penalties"][method])
    div = sum([1.0/p["penalties"][method] for p in ordered[:k]])
    avgx = sum([1.0/p["penalties"][method]*p["pos"][0] for p in ordered[:k]])/div
    avgy = sum([1.0/p["penalties"][method]*p["pos"][1] for p in ordered[:k]])/div
    error=((avgx-pos[0])**2 + (avgy-pos[1])**2)**.5
    errors[method].append(error)
    return (avgx, avgy, error, div)

kALLPOS = {}
for line in database:
    if line.split()[0] == "x" or line[0] == "#" or len(line.strip()) == 0 or line.split()[3] == "-999.0":
        continue
    parts = line.split()

    pos = tuple(map(int, parts[:2]))
    kALLPOS[pos] = 1
database.seek(0)

errors = {k:[] for k in METHODS}
for run in range(RUNS):
    ALLBEACONS = ["0x%02x" % (i+1) for i in range(20)]
    LIVEBEACONS = sorted(ALLBEACONS, key=lambda b: hashme(b,run,"live"))[:LIVEBEACONCOUNT]
    BEACONS = sorted(ALLBEACONS, key=lambda b: hashme(b,run,"beacons"))[:BEACONCOUNT]
    VALIDPOS = sorted(kALLPOS.keys(), key=lambda b: hashme(b, run, "pos"))[:int(len(kALLPOS) * SURVEYPOINTPART)]
    fingerprints = {}

    for line in database:
        if line.split()[0] == "x" or line[0] == "#" or len(line.strip()) == 0 or line.split()[3] == "-999.0":
            continue

        parts = line.split()

        pos = tuple(map(int, parts[:2]))
        if pos not in VALIDPOS:
            continue

        if not fingerprints.has_key(pos):
            fingerprints[pos] = {}

        id = parts[2]
        if id in BEACONS:
            fingerprints[pos][id] = map(float, parts[4:])
    database.seek(0)

    for walk in walks:
        positionings = {}
        for line in walk:
            if line.split()[0] == "x" or line[0] == "#" or len(line.strip()) == 0 or line.split()[3] == "999.0":
                continue

            parts = line.split()

            (x, y) = map(int, parts[:2])
            pos = (x,y)

            if not positionings.has_key(pos):
                positionings[pos] = {"heading": float(parts[3])}

            id = parts[2]
            if id in BEACONS:
                if id in LIVEBEACONS:
                    positionings[pos][id] = map(float, parts[4:])
                else:
                    positionings[pos][id] = [-105] * len(parts[4:])
        walk.seek(0)


        toprint = {}
        for y in range(22):
            for x in range(30):
                pos = (x,y)
                if positionings.has_key(pos):
                    penalties = [{"pos": p, "penalties": calc_penalties(positionings[pos],p)} for p in fingerprints]
                    print(" ".join(["%2d %2d"%pos] + ["%5.1f %4.1f %6.2f %7.3f"%WKNN(penalties, method, pos, K) for method in METHODS]))

print("\n".join([" ".join(["%7s" % method, "%5.2f m"%(avg(errors[method]) * GRID_SIZE)] + ["%5.2f m"%(percentile(errors[method], pct) * GRID_SIZE) for pct in [25, 50, 75, 95]]) for method in METHODS]), file=sys.stderr)
