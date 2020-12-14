# Donut Combinatorial Box

Original source for this problem is not known.

Given an unlimited supply of donuts of 14 different flavors.  Randomly
choose 12 donuts from the supply.

1. How many different flavors do you expect?

2. What is likelihood of 3 or fewer flavors in the box?


# Lua: Monte Carlo Simulation

Using LuaJit with 100e6 trials, 5 runs:

    > dofile('rgc_donuts.lua')
    Num trials = 100000000

    Flavor  Run 1      Run 2      Run 3      Run 4      Run 5
    1       0          0          0          0          0
    2       0          0          2          0          0
    3       339        331        356        362        368
    4       25704      25790      25934      25909      25898
    5       583117     583869     584839     584708     585453
    6       5045220    5046998    5045320    5047811    5047383
    7       19139922   19139583   19140543   19144255   19143299
    8       33966293   33960588   33969052   33966743   33966615
    9       28542878   28546265   28538311   28537788   28540816
    10      10927762   10927566   10926641   10926120   10922938
    11      1691772    1692115    1691810    1689591    1690185
    12      76993      76895      77192      76713      77045


# R: Monte Carlo Simulation

In R there is a random number generator for this condition.  The function
is rmultinom(n,size,prob).  In this case, the result is a matrix of K
rows by n columns where n is the number of trials.  K is determined by
the length of the prob vector.  This is the number of *boxes* used to
classify the number of objects, size, in each trial.  To determine the
number of flavors, we need to count the number of nonzero entries in
a column.  The following line will tabulate the results of 1e7 trials:

    table(colSums(rmultinom(10000000,12,rep(1/14,14)) != 0))

Typical output:

     3       4       5       6       7       8       9      10      11      12 
    36    2592   58759  504482 1912995 3395522 2854665 1093695  169558    7696

Which appears to be in good agreement with the Lua simulation after
adjusting for the number of trials (1e7 vs 1e8).  One problem with doing
this in a single line is that you need a lot of RAM to store the
internal results.  We could wrap this in a loop and sum up the resulting
tables.  In that case, use tabulate(data,bins) instead of table.  The
tabulate() function works like bincount() in numpy.


# Closed Form: Single Flavor

Why do I never see a single flavor?

Consider a single flavor.

1. Pick a donut (any flavor): P = 1
2. P(next donut is a match) = 1/14
3. P(11 matches) = (1/14)^11

This is a very small probability (~ 2.47e-13).  Even with 1e8 trials there
is a very small chance of seeing a single flavor (P ~ 2.47e-5).


# Closed Form: 12 Flavors

What about 12 flavors?  This requires no matches of previous donuts.

1. Pick a donut (any flavor): P = 14/14
2. P(next donut is not a match): P = 13/14
3. P(next donut is not a match): P = 12/14
4. Continue for all the donuts

    P = (14/14)*(13/14)*(12/14)*(11/14)*(10/14)*(9/14)*
        ( 8/14)*( 7/14)*( 6/14)*( 5/14)*( 4/14)*(3/14)

    P ~ 0.00076885

With 1e8 trials we expect 76885 cases of 12 flavors.  Monte Carlo results:


    76993
    76895
    77192
    76713
    77045

    Mean = 76968

