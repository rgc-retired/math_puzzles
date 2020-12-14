import itertools

#      V E N * *
#      V E N * *
#    -----------
#    * R T E E N

zzz=[]
ntrial=0
for i in itertools.permutations(range(10),5):
    v,r,e,n,t = i
    for d1 in range(10):
        for d2 in range(10):
            for d3 in range(10):
                for d4 in range(10):
                    n1=v*10000+e*1000+n*100+d1*10+d2
                    n2=v*10000+e*1000+n*100+d3*10+d4
                    n3=r*10000+t*1000+e*100+e*10+n
                    if (n1+n2)%100000 == n3:
                        zzz.append([v,r,e,n,t,d1,d2,d3,d4])
    ntrial=ntrial+1
    if ntrial%1000 == 0:
        print(ntrial,len(zzz))

print("Done with part 1")


#
# Extend this solution to the following problem
#
#       |<--- solved above
# * S E V E N * *
# * S E V E N * *
# ---------------
# F O U R T E E N
#

def make_num(x):
    s=0
    for i in x:
        s=10*s+i
    return(s)


final_solution=[]
for i in itertools.permutations(range(10),4):
    s,f,o,u=i
    for j in zzz:
        v,r,e,n,t,d1,d2,d3,d4 = j
        used=[v,r,e,n,t]
        if s in used:
            continue
        if f in used:
            continue
        if o in used:
            continue
        if u in used:
            continue
        for d5 in range(10):
            for d6 in range(10):
                n1=make_num([d5,s,e,v,e,n,d1,d2])
                n2=make_num([d6,s,e,v,e,n,d3,d4])
                n3=make_num([f,o,u,r,t,e,e,n])
                if (n1+n2 == n3):
                    final_solution.append([n1,n2,n3])
                    print(len(final_solution),":",n1,n2,n3)

###
#
# Finally -- make the following true simultaneously
#
#      * * * * * *
#      * * * * * *
#      F O U R * *     * S E V E N * *
#      S E V E N *     * S E V E N * *
#      -----------     ---------------
#      E L E V E N     F O U R T E E N
#
# Need to work more on this.
#
# We know:
#
# E = N + * + * + * + carry
# V = R + E + * + * + carry
# etc.
#

