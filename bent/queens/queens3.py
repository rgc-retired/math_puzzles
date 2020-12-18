import numpy as np
from numpy import *

# Problem:
# Position 8 queens on a chessboard such that that number of
# squares that is not attacked is a maximum
#
# Seems simple enough but the number of combinations is large
# C(64,8)~4.4 Billion.  With reflections, translations, rotations,
# etc. I am sure the number is much smaller ... but there doesn't
# seem to be an obvious alorithm to search out just the unique
# configurations.
#
# Let's take an intermediate approach.  Manually position m queens and
# calculate the effect of all possible locations for the remaining 8-m.

# Create arrays for the squares attacked by a single queen on a particular
# square (row i, column j).  Fill the array with zeros and then put ones
# at each location attacked by the queen.

def make_mask(i,j):
    xxx=zeros((8,8),'b')
    # all square in current row are attacked
    xxx[i,:]=1
    # all squares in current col are attacked
    xxx[:,j]=1
    # all squares on the nw diagonal
    ii=i-1
    jj=j-1
    while (ii>=0) and (jj>=0):
        xxx[ii,jj]=1
        ii=ii-1
        jj=jj-1
    # all squares on the se diagonal
    ii=i+1
    jj=j+1
    while (ii<8) and (jj<8):
        xxx[ii,jj]=1
        ii=ii+1
        jj=jj+1
    # all squares on the ne diagonal
    ii=i-1
    jj=j+1
    while (ii>=0) and (jj<8):
        xxx[ii,jj]=1
        ii=ii-1
        jj=jj+1
    # all squares on the sw diagonal
    ii=i+1
    jj=j-1
    while (ii<8) and (jj>=0):
        xxx[ii,jj]=1
        ii=ii+1
        jj=jj-1
    return xxx

def print_board(config):
    xxx=[]
    for i in range(8):
        www=[]
        for j in range(8):
            www.append(".")
        xxx.append(www)
        del www
    total_mask=zeros((8,8),'b')
    for i in config:
        total_mask=total_mask+mask[i]
    for i in range(8):
        for j in range(8):
            if total_mask[i,j] != 0: xxx[i][j]="X"
    for i in config:
        xxx[i/8][i%8]="Q"
    for i in xxx:
        for j in i:
            print(j,end="")
        print()

### Make mask arrays for each possible queen position
mask=[]
for i in range(8):
    for j in range(8):
        mask.append(make_mask(i,j))
mask=array(mask)

max_safe = 0
best_config=[]
best_config_list=[]
num_best=0
n=0

# Exhaustive search of all combinations
for i1 in range(64):
    for i2 in range(i1+1,64):
        for i3 in range(i2+1,64):
            print("Checking = ",i1,i2,i3,"   Max safe = ",max_safe)
            for i4 in range(i3+1,64):
                start_mask=mask[i1]+mask[i2]+mask[i3]+mask[i4]
                num_safe = sum(start_mask == 0)
                # Already below target - no need to follow this branch
                if num_safe < max_safe: continue
                for i5 in range(i4+1,64):
                    for i6 in range(i5+1,64):
                        # print("Checking = ",i1,i2,i3,i4,i5,i6,"   Max safe = ",max_safe)
                        total_mask=start_mask+mask[i5]+mask[i6]
                        num_safe = sum(total_mask == 0)
                        # Already below target - no need to follow this branch
                        if num_safe < max_safe: continue
                        for i7 in range(i6+1,64):
                            for i8 in range(i7+1,64):
                                ### Finally can check the result
                                total_mask=start_mask + mask[i5]
                                total_mask=total_mask + mask[i6]
                                total_mask=total_mask + mask[i7]
                                total_mask=total_mask + mask[i8]
                                num_safe = sum(total_mask == 0)
                                n=n+1
                                if num_safe > max_safe:
                                    max_safe=num_safe
                                    best_config=[]
                                    best_config.append(list([i1,i2,i3,i4,i5,i6,i7,i8]))
                                    num_best=1
                                elif num_safe == max_safe:
                                    num_best=num_best+1
                                    if num_best<1000: best_config.append(list([i1,i2,i3,i4,i5,i6,i7,i8]))

print("Total evaluations = ",n)
print("Max safe = ",max_safe)
print("Number of equivalent solutions = ",num_best)
print("First configuration:")
print_board(best_config[0])
print()
print("Last configuration:")
print_board(best_config[-1])

