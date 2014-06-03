import sys
def openplus(s):
    if s == "-":
        return sys.stdin
    else:
        return open(s)

colnr=int(sys.argv[1])
lines = [map(str.split, openplus(f).readlines()) for f in sys.argv[2:]]
print ("\n".join([" ".join([line[i][colnr] for line in lines]) for i in range(len(lines[0]))]))
