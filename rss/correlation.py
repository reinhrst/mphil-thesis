from __future__ import print_function
import sys, scipy.stats

files = map(file, sys.argv[1:])
div = 1
CHANNELS = ['37', '38', '39']

interestingrange = range(int(150*div), int(3150*div))

data = []
for f in files:
    data.append({ch:{x:[] for x in interestingrange} for ch in CHANNELS})

for f,d in zip(files,data):
    starttime = None
    for line in f:
        if len(line.strip()) and line[0] != '#':
            parts = line.split()
            time = float(parts[0])
            ch = parts[1]
            rss = int(parts[2])
            if starttime == None:
                starttime = time
            inttime = int((time-starttime)*div)
            if d[ch].has_key(inttime):
                d[ch][inttime].append(rss)

def avg(x):
    if len(x) == 0:
        return None
    return sum(x)/float(len(x))

for d in data:
    for ch in d:
        for i in d[ch]:
            d[ch][i] = avg(d[ch][i])

for i_d1, d1 in enumerate(data):
    for ch1 in CHANNELS:
        for i_d2, d2 in enumerate(data):
            for ch2 in CHANNELS:
                interestingkeys = filter(lambda i: d1[ch1][i] != None and d2[ch2][i] != None, interestingrange)
                a1 = [d1[ch1][i] for i in interestingkeys]
                a2 = [d2[ch2][i] for i in interestingkeys]
                result = scipy.stats.pearsonr(a1,a2)
                if i_d2 == 0 and ch2 == CHANNELS[0]:
                    if ch1 == CHANNELS[0]:
                        print("\\rowspan{3}{run %d}"%(i_d1+1), end=" ")
                    print("& ch. %s"%ch1, end=" ")
                if d1 == d2 and ch1 == ch2:
                    color = "same"
                elif ch1 == ch2:
                    color = "samechan"
                else:
                    color = "diffchan"
                print("\\correlationtable{%s}{%04.02f}" % (color, result[0]), end = " ")
                if d2 == data[-1] and ch2 == CHANNELS[-1]:
                    print("\\\\", end=" ")
                    if ch1 == CHANNELS[-1]:
                        print("\\hline")
                    else:
                        print("\\cline{2-11}")
