---
title: 'Coffee Cards'
---

# Riddler Classic

[Problem Website](https://fivethirtyeight.com/features/does-your-gift-card-still-have-free-drinks-on-it/)

From Michael Branicky, your card has been declined:

Lucky you! You've won two gift cards, each loaded with 50 free drinks from your
favorite coffee shop, Riddler Caffei-Nation. The cards look identical, and
because you're not one for record-keeping, you randomly pick one of the cards
to pay with each time you get a drink. One day, the clerk tells you that he
can't accept the card you presented to him because it doesn't have any drink
credits left on it.

What is the probability that the other card still has free drinks on it? How
many free drinks can you expect are still available?


# Solution to last week's Riddler Classic

[Solution Website](https://fivethirtyeight.com/features/how-many-times-a-day-is-a-broken-clock-right/)

Last week, lucky you had won two gift cards to your favorite coffee shop,
Riddler Caffei-Nation. The cards looked identical and each was initially loaded
with 50 free drinks. You were interested more in the drinks and less in record
keeping, so each time you redeemed a beverage you simply presented the cashier
with one of the cards at random. One sad and fateful day, however, the cashier
told you he couldn't accept the card you presented him because it was out of
drinks. What was the probability that the other card still had free drinks on
it? How many free drinks could you expect were still available?

Praise the Coffee Gods, there was a 92 percent chance that your other card was
still valid, containing at least one drink credit. What's more, you could
expect that there were about seven drinks left on that card.

So how do we get to those answers? Suppose, for the sake of generality, that
each card started with n drinks. What we want to know are how many drinks, k
(which could be anything from zero to n), remain on the other card when one
card zeros out.

Call the cards A and B. As solver Jason Ash explained, there are two
possibilities: 1) Card A runs out of drinks first and Card B has k drinks
remaining or 2) Card B runs out of drinks first and Card A has k drinks
remaining. Since the cards are identical and we pick which to use randomly,
these outcomes are equally likely, so we only need to analyze one of them, and
then we can double the probabilities that result from that analysis.

So suppose it is A that runs out and there are k
drinks left on B. For this to happen, Jason explained, we must have purchased 
n drinks on the first card, n-k
drinks on the second card and attempted one more purchase on the first card, for a total number of visits to the coffee counter of 2n-k+1
. Of those purchases, n
must have occurred on a single card. This suggests an "X choose Y" binomial formula. Specifically, the chances of there being k
drinks left on Card B are:


$${{2n-k}\choose{n}} (1/2) ^ {2n-k+1}$$

We then multiply this by two - to account for the fact that it might have been Card B that exhausted first.

$${{2n-k}\choose{n}} (1/2) ^ {2n-k}$$

If we plug in 50 for n and zero for k , we find the chance that both cards are
actually exhausted - that chance is about 8 percent, so the chance that the
other card does have at least a coffee left is about 92 percent - our first
answer.

To find the expected value of the number of coffees that remain on the other
card (k), we can sum the expression above by all of the coffee possibilities.
Specifically,

$$ \sum _{k=0} ^{k=n} {k {{2n-k}\choose{n}} (1/2) ^ {2n-k}} $$

Plug in n=50 and that equals just over seven, our second answer. And we're
done.

# Analytic Solution

This appears to be an example of a [binomial
distribution](https://en.wikipedia.org/wiki/Binomial_distribution#Probability_mass_function) of getting
50 hits on one card with 50-k hits on the other.  This is a total total
population of 100-k drinks.  If there are k drinks remaining on one card when
all 50 drinks are used on the other card, then the probability can be written
as:

$$P = {{100-k}\choose{50}} \left( \frac{1}{2} \right) ^ {100-k}$$

Where the binomial coefficient is given by:

$${N\choose{K}} = \frac{N!}{(N-K)! K!}$$

The binomial coefficient defines the number of different ways the 50 drinks on
the card are distributed.  The second term expresses the probability of picking
a particular card.  Regardless of the distribution, there is a 50% chance of
either card on each trial.  Note that I have not identified either card as
the one that is used up -- so there is no need to double the end result as
done above on FiveThirtyEight.

For values of k from 0 (no drinks remaining) on up, the probability is
calculated as:

    Remain  Probability
    0       0.07958923738717877
    1       0.07958923738717877
    2       0.07878530569639917
    3       0.07717744231484001
    4       0.0747905111092264
    5       0.07167423981300863
    6       0.06790191140179766
    7       0.0635677468442361
    8       0.05878307772692801
    9       0.0536715057506734
    10      0.04836333485225515
    ...
    20      0.007338260454779934
    ...
    30      0.00013712159295547541
    ...
    40      6.539389478359137e-08
    ...
    50      8.881784197001252e-16

The mean result is 7.038512976105055 drinks remaining.

Note that for Monte-Carlo simulation it will be difficult to reach
the rare events (e.g. more than 40 drinks remaining).  Even with 1e6
trials there is a less than 7% chance of reaching 40.

## Python Code Analytic

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


# Monte-Carlo solution

A quick monte-carlo solution seems to support these calculations.

For 1e6 trials in Python the results are:

    No drinks remain = 0.079628 (~  8%)
    Drinks remain    = 0.920372 (~ 92%)
    Mean remaining   = 7.036937
    Min remaining    = 0
    Max remaining    = 38

A Lua simulation of 10e6 trials yields a similar result:

    No drinks remain = 0.0796386
    Drinks remain    = 0.9203614
    Mean remaining   = 7.0376586
    Min remaining    = 0
    Max remaining    = 39

Repeated with LuaJit for 100e6 trials:

    Number of trials = 100000000
    Drinks per card  = 50
    Mean drinks remaining = 7.03822754
    Max  drinks remaining = 43

    Num     Probability
    0       0.07962291
    1       0.07959318
    2       0.07878037
    3       0.07715145
    4       0.07478340
    5       0.07169977
    6       0.06790037
    7       0.06356331
    8       0.05878794
    9       0.05366920
    10      0.04834840


## Python Code Monte-Carlo

Monte-carlo simulation usage:

    python coffee_cards.py [num_trials=1000] [num_drinks=50]

The output is the bincounts for each number of drinks 0..N where
N is the number of drinks on the original cards.  You can retrieve
the mean number of drinks using a weighted sum of the bin counts.

Code:

    import numpy as np
    import pandas as pd
    import sys


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
        print("Remaining drink probability (starting with N = %d):" % N)
        print(counts)


## Lua Code Monte-Carlo

Usage:

    lua coffee_cards.lua [num_trials = 1000] [num_drinks = 50]

Code:

    make_trip = function(n)
        n=n or 50
        na=n
        nb=n
        while true do
            if math.random()<0.5 then
                if na==0 then
                    return(nb)
                else
                    na=na-1
                end
            else
                if nb==0 then
                    return(na)
                else
                    nb=nb-1
                end
            end
        end
    end


    num_trials = arg[1] or 1000
    num_drinks = arg[2] or 50

    n={}
    for i=0,num_drinks do n[i]=0 end

    t1=os.time()
    for trial=1,num_trials do
        k=make_trip()
        n[k]=n[k]+1
    end
    t2=os.time()

    print("Execution time " .. t2-t1)

    nmax=0
    for i=0,num_drinks do
        if n[i]>0 then
            nmax=i
        end
    end

    s=0
    for i=0,num_drinks do s=s+i*n[i]/num_trials end

    print("Number of trials = " .. num_trials)
    print("Drinks per card  = " .. num_drinks)
    print("Mean drinks remaining = " .. s)
    print("Max  drinks remaining = " .. nmax)

    for i=0,nmax do print(i,n[i]) end

