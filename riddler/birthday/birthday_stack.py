# The three birthday party solution from stackexchange.
#
# [Website](https://math.stackexchange.com/questions/25876/probability-of-3-people-in-a-room-of-30-having-the-same-birthday)
#
#
# The code for birthday() works
# The code for birthday2() works and should be identical to the above.
#
# ****************************************************************
# *** WARNING NOTE CAUTION: The code for birthday3() is broken ***
# ****************************************************************

import math
import decimal
from decimal import Decimal

def birthday(n=87):
    """
    Calculate the probability of three or more people with the same
    birthday in a group of n people.  Assume birthdays are uniformly
    distributed over the 365 days in a year
    """
    m=365
    ulim=n//2
    p=0
    for i in range(ulim+1):
        p=p+(math.factorial(m)/math.factorial(m-n+i))*(math.factorial(n)/math.factorial(n-2*i))/(math.factorial(i)*pow(2,i)*pow(m,n))
    p=1-p
    return(p)

def ffactorial(m,n):
    return( Decimal(math.factorial(m))/Decimal(math.factorial(m-n)) )


def birthday2(n=87):
    """
    Calculate the probability of three or more people with the same
    birthday in a group of n people using falling factorials.  This
    should give exactly the same answer as birthday() above.
    """
    m=365
    ulim=n//2
    p=0
    for i in range(ulim+1):
        p=p+ffactorial(n,2*i)*ffactorial(m,n-i)/(Decimal(math.factorial(i))*pow(2,i)*pow(m,n))
    p=1-p
    return(p)


def birthday3(n=87,M=3):
    """
    Calculate the probability of M or more people with the same
    birthday in a group of n people.  Assume birthdays are uniformly
    distributed over the 365 days in a year

    This may assume M>=3 but the code appears to be broken for M=4.
    For M=3 the code seems to work
    """
    m=365
    p=0
    for k in range(2,M):
        ulim=n//k
        for i in range(ulim+1):
            p=p+ffactorial(n,k*i)*ffactorial(m,n-i)/(math.factorial(i)*pow(math.factorial(k),i)*pow(m,n))
    p=1-p
    return(p)

