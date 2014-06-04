from __future__ import print_function
STEPS=10
BEACONS = [1,2,5,10,15,20]
DROPRATE=.4
for i in range(STEPS):
    print("& %d"%(i+1), end=" ")
print("\\\\ \\hline")
for b in BEACONS:
    print("%2d beacon"%b, end="")
    if b > 1:
        print("s", end=" ")
    else:
        print(" ", end=" ")
    for i in range(STEPS):
        rate = ((1-((1-(DROPRATE**(i+1)))**b))*100) 
        if rate < 10:
            print("& %4.02f\\%%" % rate , end=" ")
        elif rate < 99.95:
            print("& %4.01f\\%%" % rate , end=" ")
        else:
            print("&  100\\%%" % () , end=" ")
    print("\\\\ \\hline")
