from __future__ import print_function
import sys, math

HEADING_INTERVAL=5
BRP_HIGH_PENALTY_CUTOFF= 3
BRP_HIGH_PENALTY_FACTOR= 1000
BRP_LOW_PENALTY_FACTOR = .125
K = 5
METHODS=['SSD', 'SSD-O', 'BRP', "BRP-RPM"]

database = file(sys.argv[1])
walks = map(file, sys.argv[2:])

fingerprints = {}

MAX=0
NNTH=1
MEAN=2
RPM=3
HEADING_BASE=4

def avg(seq):
    return sum(seq)/float(len(seq))

def percentile(seq, pct):
    return sorted(seq)[min(len(seq) * pct / 100, len(seq)-1)]

def calc_BRP(measurementRSS, fingerprintRSS):
    diff = measurementRSS - fingerprintRSS
    if diff > BRP_HIGH_PENALTY_CUTOFF:
        return diff * BRP_HIGH_PENALTY_FACTOR
    if diff >=0:
        return diff
    return -diff*BRP_LOW_PENALTY_FACTOR


def calc_penalties(positioning, candidate_position):
    "Calculates penalties for all methods, to place this positioning measurement at the candidate position"
    fingerprint = fingerprints[candidate_position]
    heading_col = HEADING_BASE + int((positioning["heading"]+HEADING_INTERVAL/2)%360)/HEADING_INTERVAL
    return {
        'SSD':     sum([(positioning[id][MEAN]-fingerprint[id][       MEAN])**2 for id in fingerprint])**.5,
        'SSD-O':   sum([(positioning[id][MEAN]-fingerprint[id][heading_col])**2 for id in fingerprint])**.5,
        'BRP':     sum([calc_BRP(positioning[id][MAX],fingerprint[id][MAX]) for id in fingerprint]),
        'BRP-RPM': sum([calc_BRP(positioning[id][MAX],fingerprint[id][RPM]) for id in fingerprint]),
    }

def WKNN(penalties, method, pos, k):
    ordered = sorted(penalties, key=lambda p: p["penalties"][method])
    div = sum([1.0/p["penalties"][method] for p in ordered[:k]])
    avgx = sum([1.0/p["penalties"][method]*p["pos"][0] for p in ordered[:k]])/div
    avgy = sum([1.0/p["penalties"][method]*p["pos"][1] for p in ordered[:k]])/div
    error=((avgx-pos[0])**2 + (avgy-pos[1])**2)**.5
    errors[method].append(error)
    return (avgx, avgy, error)

for line in database:
    if line[0] == " " or line[0] == "#" or len(line.strip()) == 0 or line.split()[3] == "-999":
        continue

    parts = line.split()

    (x, y) = map(int, parts[:2])
    pos = (x,y)
    if not fingerprints.has_key(pos):
        fingerprints[pos] = {}

    id = parts[2]
    fingerprints[pos][id] = map(float, parts[4:])

errors = {k:[] for k in METHODS}
for walk in walks:
    positionings = {}
    for line in walk:
        if line[0] == " " or line[0] == "#" or len(line.strip()) == 0 or line.split()[3] == "-999.0":
            continue

        parts = line.split()

        (x, y) = map(int, parts[:2])
        pos = (x,y)

        if not positionings.has_key(pos):
            positionings[pos] = {"heading": float(parts[3])}

        id = parts[2]
        positionings[pos][id] = map(float, parts[4:])

    for y in range(22):
        for x in range(30):
            pos = (x,y)
            if positionings.has_key(pos):
                penalties = [{"pos": p, "penalties": calc_penalties(positionings[pos],p)} for p in fingerprints]
                print(" ".join(["%2d %2d"%pos] + ["%4.1f %4.1f %4.1f"%WKNN(penalties, method, pos, K) for method in METHODS]))

print
for method in errors:
    
    print(method, "%5.2f"%avg(errors[method]), ";".join(["%5.2f"%percentile(errors[method], pct) for pct in [0, 25, 50, 75, 95,100]]))
