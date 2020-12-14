# Support for Cryptic Arithmetic problems and Prime Numbers
#
# a = data frame with columns for each variable
#
# get_symbols(symbol string): extact and return unique symbols
# make_num(a,string): make a number from columns of a matching string

# Note that two packages provide a permutation generator:
# e1071 is very fast but only generates a full width permutation.
#    You can remove some columns and then just select the unique
#    rows but this is relatively slow and uses a LOT OF MEMORY!!!
# gtools requires you to specify the number of variables and is
#    more memory efficient but runs about 2 orders of magnitude slower!!!
#
library(gtools)

# Simple primality test
# see https://en.wikipedia.org/wiki/Primality_test
is_prime = function(n) {
  if (n<=3) { return(n>1) }
  if ((n%%2 == 0) | (n%%3 == 0)) { return(F) }
  i=5
  while (i*i<n) {
    if ((n%%i == 0) | (n%%(i+2) == 0)) { return(F) }
    i=i+6
  }
  return(T)
}

### -----------------
### WARNING - CAUTION
### -----------------
###
### There is an undetected overflow issue in these routines for n > 100e6
### Need to debug this further.  Really need bigger integers!!!!!
###
### I think the problem is in modPow where b^2 can overflow or in the modulo
### arithmetic with big numbers.  In any event, modPow does not work correctly.
###
### This is simple in Python but not so easy here.
### -----------------


# Modular exponentiation -- needed for more advanced primality tests
# See https://en.wikipedia.org/wiki/Modular_exponentiation
#
# Efficiently calculates (base^exponent) %% modulus without using huge numbers.
#
# This is the simplest method
modular_pow = function(base, exponent, modulus) {
  if (modulus == 1) { return(0) }
  c=1
  for (e_prime in 0:(exponent-1)) {
    c=(c*base)%%modulus
  }
  return(c)
}

# Another method called right-to-left
# Converted from Lua
modPow = function(b,e,m) {
  if (m==1) {return(0)}
  r=1
  b=b%%m
  while (e>0) {
    if (e%%2 ==1) { r = (r*b) %% m}
    e=floor(e/2)
    b=(b^2) %% m
  }
  return(r)
}

## Fermat primality test
## see: https://en.wikipedia.org/wiki/Fermat_primality_test
##
## Test to see if number is composite or (probably) prime
##
## n = number to test for primality
## k = number of times to check for compositeness
##
## Note that a TRUE result does not ensure a prime number.
## The larger the value of k the more confidence of primality.
##
## A FALSE result does ensure a composite.
fermat_test = function(n,k) {
  if (n<4) { return(n>1) }
  for (i in 1:k) {
    m=sample(n-3,1)+1
    if (modPow(m,n-1,n) != 1) {
      return(F)
    }
  }
  return(T)
}

## Miller-Rabin test
## see: https://en.wikipedia.org/wiki/Miller-Rabin_primality_test
##
## Another probabilistic primality test
##
## The pseudo-code on Wikipedia really likes the continue/next escape
##
## n = number to test for primality
## k = number of repeats for confidence
##
## Error bound upper limit known to be < 4^-k and is usually <8^-k
## This is the probabiliy of a composite testing as prime
miller_rabin_test = function(n,k) {
  if (n<4) { return(n>1) }
  if (n%%2 == 0) {return(F)}
  ## write n = 2^r * d + 1 with d=odd
  ## just keep extracting factors of 2 from (n-1)
  d=n-1
  r=0
  while (d%%2 == 0) {
    r=r+1
    d=d/2
  }
  for (i in 1:k) {
    a=sample(n-3,1)+1
    x=modPow(a,d,n)
    if (x==1 | x==(n-1)) { next }
    j=1
    while (j<r) {
      x=modPow(x,2,n)
      if (x == (n-1)) { break }
      j=j+1
    }
    if (j>=r) { return(F) }
  }
  return(T)
}


extract_factor = function(n,i) {
    zzz=c()
    while (n %% i == 0) {
        n=n/i
        zzz=c(zzz,i)
    }
    return(list(n,zzz))
}

prime_factor = function(n) {
    xxx=unlist(extract_factor(n,2))
    n=xxx[1]
    fff=xxx[-1]
    i=3
    while(i<=n) {
        xxx=unlist(extract_factor(n,i))
        n=xxx[1]
        fff=c(fff,xxx[-1])
        i=i+2
    }
    return(fff)
}


# Cryptic arithmetic functions

get_symbols = function(s) {
  symbols=unique(unlist(strsplit(s,"")))
  return(symbols)
}

make_num = function(a,s,num_base=10) {
  b=unlist(strsplit(s,""))
  v=NA
  for (i in b) {
    if (all(is.na(v))) {
      v=a[i]
    } else {
      v=num_base*v+a[i]
    }
  }
  return(v)
}

make_crypt_df = function(s,num_base=10) {
  symbols=get_symbols(s)
  m=length(symbols)
  a=gtools::permutations(num_base,m)-1
  a=as.data.frame(a)
  colnames(a)=symbols
  return(a)
}

print_num = function(a,s,k) {
  print(paste0(s," = ",make_num(a,s)[k],collapse=""))  
}
