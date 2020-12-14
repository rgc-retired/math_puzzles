import numpy
import numpy.random

from numpy import bincount,any,sqrt
from numpy.random import randint

def birthday(num_people=88, num_trials=1000000, target_number=3):
    """
    Solve the generalized birthday problem using Monte-Carlo simulation.

    Given num_people in a room what is the probability that target_number
    or more of them share the same birthday.

    Assume years have 365 days

    Returns mean, standard deviation of the estimate
    """
    n=0
    for i in range(num_trials):
        m=bincount(randint(1,366,num_people))
        if any(m>=target_number):
            n=n+1
    # Mean of the results
    p=n/num_trials
    # std of the results
    # This works since all data is 0,1 then data**2 = 0,1 as well
    q=sqrt(n*(1-p)/(num_trials-1))
    return(p,q)


# Return P(less than 3 people with same birthday)
# Note this is 1-p(from above) and only works for 3 birthdays
def foo2(num_people=88, num_trials=1000000):
    n=0
    for i in range(num_trials):
        m=bincount(randint(1,366,num_people))
        if any(m>2):
            n=n+1
    p=1-n/num_trials
    return(p)

if __name__ == "__main__":
    # Set this true to run some example code
    if False:
        www=[]
        # Set random seed for reproducible results
        numpy.random.seed(42)
        for i in range(10):
            www.append(birthday(87,1000000,3))
            print("Completed trial",i,"of 0..9")
        www=numpy.array(www)

