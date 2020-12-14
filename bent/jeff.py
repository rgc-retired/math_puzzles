import itertools
import sympy

#  Cryptic addition in base 13:
#
#      HOWIE + FRED + CHUCK + JEFF = JUDGE
#
#      JUDGE is prime
#      FRED, CHUCK, and JEFF are prime
#      HOWIE is the product of 7 prime factors
#
# Unique symbols span all 13 digits
#
# To start with look only at JEFF, FRED, and JUDGE (7 symbols)
#
#      jefrdug --> 7679 solutions
#
# Add chk (10 symbols)
#
#      This actually makes things worse since there are 13**3 more
#      permutations to consider!
#
# Bite the bullet and run everything!!!
#
# ****************************************************
# *** WARNING - CAUTION - nearly 4 hour runtime!!! ***
# ****************************************************
#
# Symbol set = jefrdugchkowi
#
# The primality constraints result in 9951 solution sets.
# Adding the equation limits this to one unique solution.
#
# It turns out that the primality decisions are fairly
# expensive.  The complete equation is about the same
# as one primality check so I will put that first and
# try this again.
#
# Not sure but I think it runs even slower!!!
# I get a single unique solution, however.
#
# Base-13 digits
#
#    In [217]: a[k]
#    Out[217]:
#           j   e  f  r  d  u  g  c  h  k  o  w   i
#    9798  12  11  6  1  5  4  9  7  3  2  8  0  10
#
# Base-10 solutions:
#
#    x_jeff[k]  = 28307
#    x_fred[k]  = 13499
#    x_chuck[k] = 207287
#    x_howie[k] = 103400
#    x_judge[k] = 352493

def num_factors(n):
    return sum([i for i in sympy.factorint(n).values()])


def make_num(a,s,num_base=10):
    """
    Given a dictionary of symbol values with symbol as the key
    Given a string representing a number
    Given the number base

    Convert string in s to number using dictionary in a and num_base
    """
    n=0
    for i in s:
        n=num_base*n+a[i]
    return(n)

nnn=0
zzz=[]
a=dict()
print('  j  e  f  r  d  u  g  c  h  k  o  w  i')
for i in itertools.permutations(range(13),13):
    nnn=nnn+1
    if nnn % 10000000 == 0:
        print('nnn = ',nnn,'   solutions = ',len(zzz))
    a['j'],a['e'],a['f'],a['r'],a['d'],a['u'],a['g'],a['c'],a['h'],a['k'],a['o'],a['w'],a['i'] = i
    if (a['j']==0) or (a['f']==0) or (a['c']==0) or (a['h']==0):
        continue
    n_jeff=make_num(a,'jeff',13)
    n_fred=make_num(a,'fred',13)
    n_judge=make_num(a,'judge',13)
    n_chuck=make_num(a,'chuck',13)
    n_howie=make_num(a,'howie',13)

    if n_howie+n_fred+n_chuck+n_jeff != n_judge:
        continue
    if not sympy.isprime(n_jeff):
        continue
    if not sympy.isprime(n_fred):
        continue
    if not sympy.isprime(n_judge):
        continue
    if not sympy.isprime(n_chuck):
        continue
    if num_factors(n_howie) != 7:
        continue 
    print(("%3d"*13) % i)
    zzz.append(i)

