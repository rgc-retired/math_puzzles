swap = function(a,i,j) {
    t=a[i]
    a[i]=a[j]
    a[j]=t
    return(a)
}

is.even = function(k) {
    k%%2 == 0
}

gen_perm = function(k,a) {
    if (k==1) {
        print(a)
    } else {
        gen_perm(k-1,a)
        for (i in 1:(k-1)) {
            if (is.even(k)) {
                a=swap(a,i,k)
            } else {
                a=swap(a,1,k)
            }
            gen_perm(k-1,a)
        }
    }
}

