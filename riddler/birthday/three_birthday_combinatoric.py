# [Original Source](https://swarbrickjones.wordpress.com/2016/05/08/the-birthday-problem-ii-three-people-or-more/)
#
# This is the general code for probability of M (or more) people having the
# same birthday in a group of N people (assuming 365 days in a year).
#
# This code has been verified through M=5 against a list in OEIS for the
# cases just above/below p=0.5
#
# I also worked through the derivation and understand the code with only
# a slight question about the range on the for m loop.  I understand that
# we don't want n-m to go negative (that would access illegal index) but
# I'm not sure I understand the physical meaning.  I think it means that
# if there are less than M items we can sum up to the case of M items and
# have to stop when we run out of things to sum.

import time
import math
from decimal import Decimal
from decimal import getcontext

#bit of a trade off between speed/memory and precision here
getcontext().prec = 50

def binom(n, m):
    return Decimal(math.factorial(n)) / (Decimal(math.factorial(m)) * Decimal(math.factorial(n-m)))

def get_birthday_prob(N, M):
    current_row = [Decimal(0)] * (N + 1)
    
    #base case
    for k in range(M):
        current_row[k] = Decimal(1)

    #recursion
    for d in range(1, 365):
        new_row = [Decimal(0)] * (N + 1)
        for n in range(N + 1):
            s = Decimal(0)
            for m in range(min(n + 1, M)):
                s += binom(n, m) * current_row[n-m]
            new_row[n] = s
        current_row = new_row

    # print("Debug - current_row[N] = ",current_row[N])
    # print("Debug - math power     = ",Decimal(math.pow(365,N)))

    # The original code blows up for math.pow(365,N) when N is big
    # complement_prob = current_row[N] / Decimal(math.pow(365, N))
    complement_prob = current_row[N] / pow(Decimal(365), N)

    return float(1 - complement_prob)

#
# Compared against table found in a separate source.
# All results agree to all displayed digits except for
# the case of P(87,3) where this code yields a value
# the ends in ...631 while the table ended in ...632.
#
#
t1=time.time()
print("P(23,2) = ",round(get_birthday_prob(23, 2),12))
print("P(22,2) = ",round(get_birthday_prob(22, 2),12))
t2=time.time()
print("Execution time = ",t2-t1)
print("-"*40)

t1=time.time()
print("P(88,3) = ",round(get_birthday_prob(88, 3),12))
print("P(87,3) = ",round(get_birthday_prob(87, 3),12))
t2=time.time()
print("Execution time = ",t2-t1)
print("-"*40)

t1=time.time()
print("P(187,4) = ",round(get_birthday_prob(187, 4),12))
print("P(186,4) = ",round(get_birthday_prob(186, 4),12))
t2=time.time()
print("Execution time = ",t2-t1)
print("-"*40)

t1=time.time()
print("P(313,5) = ",round(get_birthday_prob(313, 5),12))
print("P(312,5) = ",round(get_birthday_prob(312, 5),12))
t2=time.time()
print("Execution time = ",t2-t1)
print("-"*40)
