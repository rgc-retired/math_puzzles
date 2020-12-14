import sympy
import time

## From Bent: 2000_1 Computer Bonus
## Computer Bonus
## 
## Find the smallest integer greater than one which has the property that
## the sum of all the integral divisors of its square equals a perfect
## cube. One and N are both divisors of N.
## 
## -- Pierre de Fermat (circa 1650)
##
## Smallest solution (other than 1) = 43098
## This is also the only solution below 1e7
##

max_n = 1_000_000
solutions = []

t1=time.time()
for n in range(1,max_n+1):
    x=sympy.factorint(n*n)
    s=1
    for k in x:
        t=1
        for m in range(x[k]):
            t=k*t+1
        s=s*t
    # s = sum of the factors of the square of n
    # Check to see if it is a perfect cube
    c=round(s**(1/3))
    if c*c*c == s:
        print("Solution = ",n,"   Time = ",time.time()-t1)
        solutions.append(n)
t2=time.time()
print("Total elapsed time = ",t2-t1)
print("Largest value tested = ",max_n)
print("Number of solutions = ",len(solutions))
print("Solution set:")
print(solutions)

