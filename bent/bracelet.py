import itertools
import collections
import time

# Check to see if d1 matches d2 or any circular rotation of d2
def foo(d1,d2):
    for i in range(len(d1)):
        if d1==d2:
            return(True)
        d2.reverse()
        if d1==d2:
            return(True)
        d2.reverse()
        d2.rotate()
    return(False)

# Check to see if vector x (or a rotation) is already in list c
def new_row(c,x):
    for i in c:
        if foo(i,x):
            return(False)
    return(True)

# Create a list of all possible n-tuples and only store the
# ones that have the correct number of digits
t1=time.time()
b=[]
for i in itertools.product([1,2,3,4,5],repeat=10):
    if i.count(1)==2 and i.count(2)==2 and i.count(3)==2 and i.count(4)==2:
        b.append(i)
t2=time.time()
print("Number of candidate solutions = ",len(b))
print("Setup time (secs) = ",t2-t1)

# Convert to deque for rapid comparisons
b=[collections.deque(i) for i in b]
c=[]

t1=time.time()
for n,i in enumerate(b):
    if n%1000 == 0:
        print("Progress = ",n,"   Solutions = ",len(c))
    if new_row(c,i):
        c.append(i)

t2=time.time()
print("Number of solutions = ",len(c))
print("Solution time (secs) = ",t2-t1)

