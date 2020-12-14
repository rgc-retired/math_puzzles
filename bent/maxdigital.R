maxdigital = function(n) {
    return(length(unique(strsplit(as.character(n),'')[[1]])) == 10)
}

find_solution = function(divisor=3) {
    n = round(9876543210 / divisor)
    while(T) {
        if (maxdigital(n)) {
            if (maxdigital(divisor*n)) { return(c(n,divisor*n)) }
        }
        n=n-1
    }
}
