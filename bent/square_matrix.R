is_a_square = function(n) { n == round(sqrt(n))^2 }

m=c(1000,100,10,1)

ntrials=10000000

# Create a matrix with columns that are valid squares
s=(32:99)^2
s=s[!grepl('0',s)]
a=sapply(s,function(x) {as.numeric(unlist(strsplit(as.character(x),'')))})


t1=Sys.time()

# Exhaustive search of all possible grids
#
for (i1 in 1:ncol(a)) {
    for (i2 in 1:ncol(a)) {
        for (i3 in 1:ncol(a)) {
            for (i4 in 1:ncol(a)) {
                colset=c(i1,i2,i3,i4)
                b=a[,colset]
                if (all(is_a_square(apply(b,1,function(x) {sum(x*m)})))) {
                    print(colset)
                    print(b)
                }
            }
        }
    }
}
t2=Sys.time()
print("Exhaustive Search:")
print(t2-t1)

t1=Sys.time()
# Selective search
# Final column must be index = 1, 5, or 32
for (i1 in 1:ncol(a)) {
    for (i2 in 1:ncol(a)) {
        for (i3 in 1:ncol(a)) {
            for (i4 in c(1,5,32)) {
                colset=c(i1,i2,i3,i4)
                b=a[,colset]
                if (all(is_a_square(apply(b,1,function(x) {sum(x*m)})))) {
                    print(colset)
                    print(b)
                }
            }
        }
    }
}
t2=Sys.time()
print("Selective Search:")
print(t2-t1)

