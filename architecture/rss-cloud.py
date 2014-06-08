from __future__ import print_function
import sys, math, hashlib, os

database = file(sys.argv[1])
walks = map(file, sys.argv[2:])

fingerprints = {}
for line in database:
    if line.split()[0] == "x" or line[0] == "#" or len(line.strip()) == 0:
        continue

    parts = line.split()

    pos = tuple(map(int, parts[:2]))

    if not fingerprints.has_key(pos):
        fingerprints[pos] = {}

    id = parts[2]
    fingerprints[pos][id] = int(parts[5])

for walk in walks:
    for line in walk:
        if line.split()[0] == "x" or line[0] == "#" or len(line.strip()) == 0:
            continue

        parts = line.split()

        pos = tuple(map(int, parts[:2]))

        id = parts[2]
        print("%4d %4d" % (int(parts[5]), fingerprints[pos][id]))
