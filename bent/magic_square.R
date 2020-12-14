library(gtools)

p=read.table('primes.txt')
p=p[,1]
p=p[p<100]

a=permutations(25,4,p)
s=apply(a,1,sum)
a=a[s==202,]

print(paste0("size of matrix = ",dim(a)))

# Monte Carlo attempt to get lucky 
# No joy after 31e6 tries
if (F) {
    t1=Sys.time()
    for (i in 1:10000000) {
        s=sample(nrow(a),4)
        b=a[s,]
        if (all(apply(b,2,sum)==202)) {
            if (length(unique(as.vector(b)))==16) {
                print(b)
                break
            }
        }
    }
    t2=Sys.time()
    print(t2-t1)
}

# For each possible row in a
# Pick a potential set for the first column
# For each first row/column pick a potential set for second row
# Pick potential set for second column
# etc. until you find a solution or find zero solutions



# Get a row suitable for inclusion in the b matrix
# at a position given by rownum.  The first colnum
# columns must match the values in b[rownum,].
get_row = function(a,b,rownum,colnum) {
    # match the leading column values
    ### s=(a[,1:(colnum-1)]==b[rownum,(1:colnum-1)])
    s=apply(a,1,function(x) {all(x[1:(colnum-1)]==b[rownum,(1:colnum-1)])})
    c=matrix(a[s,],ncol=4)
    # eliminate rows that duplicate existing values
    s=apply(c,1,function(x) {!any(x[colnum:4] %in% b)})
    c=matrix(c[s,],ncol=4)
    return(c)
}

# Get a column suitable for inclusion in the b matrix
# at a position given by colnum.  The first rownum
# values must match the values in b[,colnum].
get_col = function(a,b,rownum,colnum) {
    # match the leading row values
    ### s=(a[,1:(rownum-1)]==b[1:(rownum-1),colnum])
    s=apply(a,1,function(x) {all(x[1:(rownum-1)]==b[1:(rownum-1),colnum])})
    c=matrix(a[s,],ncol=4)
    # eliminate rows that duplicate existing values
    s=apply(c,1,function(x) {!any(x[rownum:4] %in% b)})
    c=matrix(c[s,],ncol=4)
    return(c)
}

# At any point the b matrix contains a partial solution
#
b=matrix(rep(0,16),ncol=4)

# Starting at row 247 based on the known solution
# Row 247 should be a solution

for (i1 in 247:nrow(a)) {
    print(paste('Status = ',paste(a[i1,],collapse=' ')))
    b[1,]=a[i1,]
    c=get_col(a,b,2,1)
    if (nrow(c)==0) {
        next
    }
    b2=b
    for (i2 in 1:nrow(c)) {
        b2[,1]=c[i2,]
        d=get_row(a,b2,2,2)
        if (nrow(d)==0) {
            next
        }
        b3=b2
        for (i3 in 1:nrow(d)) {
            b3[2,]=d[i3,]
            # Check the first two elements on the diagonal
            s=apply(a,1,function(x) {all(x[1:2]==c(b3[1,1],b3[2,2]))})
            if (sum(s)==0) {
                next
            }
            # Check the last two elements on the anti-diagonal
            s=apply(a,1,function(x) {all(x[3:4]==c(b3[2,3],b3[1,4]))})
            if (sum(s)==0) {
                next
            }
            e=get_col(a,b3,3,2)
            if (nrow(e)==0) {
                next
            }
            b4=b3
            for (i4 in 1:nrow(e)) {
                b4[,2]=e[i4,]
                f=get_row(a,b4,3,3)
                if (nrow(f)==0) {
                    next
                }
                b5=b4
                for (i5 in 1:nrow(f)) {
                    b5[3,]=f[i5,]
                    # Check the first three elements on the diagonal
                    s=apply(a,1,function(x) {all(x[1:3]==c(b5[1,1],b5[2,2],b5[3,3]))})
                    if (sum(s)==0) {
                        next
                    }
                    # Check the last three elements on the anti-diagonal
                    # This line originally had a typo that prevented finding
                    # a solution.
                    s=apply(a,1,function(x) {all(x[2:4]==c(b5[3,2],b5[2,3],b5[1,4]))})
                    if (sum(s)==0) {
                        next
                    }
                    g=get_col(a,b5,4,3)
                    if (nrow(g)==0) {
                        next
                    }
                    b6=b5
                    for (i6 in 1:nrow(g)) {
                        b6[,3]=g[i6,]
                        h=get_row(a,b6,4,4)
                        if (nrow(h)==0) {
                            next
                        }
                        b7=b6
                        for (i7 in 1:nrow(h)) {
                            b7[4,]=h[i7,]
                            # Feasible Solution -- now check the diagonals
                            if (sum(diag(b7)) != 202) {
                                next
                            }
                            s=b7[1,4]+b7[2,3]+b7[3,2]+b7[4,1]
                            if (s != 202) {
                                next
                            }
                            print("Solution:")
                            print(b7)
                        }
                    }
                }
            }
        }
    }
}

