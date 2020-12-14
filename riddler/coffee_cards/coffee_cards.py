import numpy as np
import pandas as pd
import sys
import time


def make_trip(N=50):
    """
    Simulate random selection of coffee cards
    Each card starts with N drinks.
    Randomly pick a card until one of them runs out.
    When a card runs out what are the odds there are drinks
    left on the other card.

    Output = number of drinks remaining on other card
             when the selected card is exhausted
    """
    Na=N
    Nb=N
    while 1:
        if np.random.rand()<0.5:
            if Na==0:
                return(Nb)
            else:
                Na=Na-1
        else:
            if Nb==0:
                return(Na)
            else:
                Nb=Nb-1

if __name__ == "__main__":
    t1=time.time()
    www=[]
    num_trials=1000
    N=50
    if len(sys.argv)>1:
        num_trials=int(sys.argv[1])
    if len(sys.argv)>2:
        N=int(sys.argv[2])

    drinks=np.zeros(N+1,'i')
    for i in range(num_trials):
        k=make_trip(N)
        drinks[k]=drinks[k]+1
    counts=pd.DataFrame({'n':drinks})
    counts=counts.reset_index()
    counts.columns=['Drinks','Count']
    print("Remaining drink probability (starting with N = %d):" % N)
    print(counts)
    nzbins=counts.Drinks[counts.Count != 0].values
    print("Min Remaining = ",nzbins[0])
    print("Max Remaining = ",nzbins[-1])
    print("Mean remaining = ",sum(counts.Drinks*counts.Count)/sum(counts.Count))
    t2=time.time()
    print("Execution time (seconds) = ",t2-t1)

