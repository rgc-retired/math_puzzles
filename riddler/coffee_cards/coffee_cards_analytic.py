import math

# Hooray for Python large integers!
def bcoeff(N,K):
    return math.factorial(N)/(math.factorial(N-K)*math.factorial(K))

l=list(range(11))+[20,30,40,50]
mean_result=0
mlast=0
for m in l:
    mean_result = mean_result + m*bcoeff(100-m,50)*(0.5**(100-m))
    if m>mlast+1:
        print("...")
    print(m,bcoeff(100-m,50)*(0.5**(100-m)))
    mlast=m

print()
print("Mean remaining drinks = ",mean_result)

