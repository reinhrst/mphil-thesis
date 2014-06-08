from __future__ import print_function
STEPS=range(1,11)
BEACONS = [1,2,5,10,15,20]
DROPRATE=.38
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
        rate = ((1-((1-(DROPRATE**i))**b))*100) 
        print("\\packetlosscell{",end="")
        if rate < 1:
            print("%4.02f" % rate , end="")
        elif rate < 10:
            print("%3.01f" % rate , end="")
        elif rate < 99.95:
            print("%2.0f" % rate , end="")
        else:
            print(" 100" , end="")
        print("\\%}",end=" ")
    print("\\\\ \\hline")
