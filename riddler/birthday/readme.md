# Generalized Birthday Problem

The way it all started was:  How many people needed in a room to have at least
50% chance that three or more of them share the same birthday?

This is much more difficult to calculate than the standard 2 person problem.

## Problem Statement

Originally seen on [R-bloggers](https://www.r-bloggers.com/three-birthdays-and-a-numeral/)
that referenced a problem from [the Riddler](https://fivethirtyeight.com/features/who-wants-to-be-a-riddler-millionaire/)
with a [solution](https://fivethirtyeight.com/features/can-you-escape-the-enemy-submarines/)
in the Riddler as the solution to last week's Riddler Classic.

The problem is easily generalized to how many people required such that `M`
of them have the same birthday.

## Initial Investigation

Some discussion on [stackexchange](https://math.stackexchange.com/questions/25876/probability-of-3-people-in-a-room-of-30-having-the-same-birthday) is sort
of confusing but might have some interesting ideas.  There are some closed
form solutions (and approximations).  According to one of the comments the
closed form solutions are wrong (they include some double counting) so I
looked into the *correct* solution (see section on Direct Solution below).

The easiest thing to do is Monte Carlo but the case of three people is hard
to calculate since P(n=87 people) is almost (but not quite) 50%.  The
solution for 88 people is well above 50% so that isn't too difficult to
calculate.

## Confidence interval

This started me looking into the confidence interval for a Monte Carlo
simulation.  I didn't really find any good answers other than to assume we have
a *normal or binomial* distribution and just use the traditional confidence
intervals based on the statistics of the Monte Carlo variable itself.  The
standard deviation of the Monte Carlo samples is used along with the square
root of the number of samples in the classical confidence interval calculation

I couldn't actually find a good web site for this.  The best I found was
a pdf from the Army talking about [simulations of weapon systems](https://www.arl.army.mil/arlreports/2015/ARL-TN-0684.pdf).
This was fairly good and suggested using the classical confidence iterval
as one of three methods.  As a note: the results in Table 4 for the Length of
the Half-Width are off by a factor of 10 (too large) for the cases of 10K and
100K samples.

The main problem is that the probability for n=87 people is very close
to 50% (about 49.945%) so you need a relatively large number of samples
to have statistical confidence that this is actually less than 50%.
This is compounded by the fact that even a small error in the Monte Carlo
data results in a large change in the estimate for the required number
of samples.

In thirty separate Monte-Carlo simulations of the case n=87 people with
one million trials per simulation I have the following results:

    27 trials have mean < 0.5
    3 trials have mean > 0.5
    All trials have std ~ 0.5

    6 trials achieve statistical significance, 24 did not.
    The most significant trial had z ~ 3.86, p < 5.7e-5
    The worst trial had z ~ 1.24 in the wrong direction, p ~ 0.1075

    Pooled mean = 0.4993917
    Pooled significance: z ~ 6.66, p < 1.4e-11

The full set of data seems to safely indicate significance has been achieved -
but how do you estimate that from the individual trials?  That is difficult.
Maybe the best solution is just to be mindful of the risks and run as many
trials as you can.

The variation in results is explored in detail below.

For the simulation about half the samples are 1 and half are 0.  The
standard deviation is about 0.5 (the theoretical max) so, for 95%
confidence we require:

    (0.5-mean(sim_data))/(std(sim_data)/sqrt(num_samples))>1.96

or

    sqrt(num_samples) > 1.96*std(sim_data)/(0.5-mean(sim_data))

or

    num_samples > (1.96*std(sim_data)/(0.5-mean(sim_data)))**2

If I knew the true mean ahead of time I could estimate the number of
samples.  If I have to use the mean of the sample data this may be
very sensitive to small errors in the simulated result (note we are
almost dividing by zero!).

If we knew the true mean we would calculate:


    num_samples > ((1.96*0.5)/(0.5-0.499454850632))**2

    num_samples > 3.2e6

Unfortunately, when I use actual simulation data I get a much different
result.  Sometimes the simulation is actually larger than 0.5!

In one trial of 1e6 samples I have the following data:

    mean(sim_data) = 0.499741
    std(sim_data)  = 0.5

By itself, this does not achieve 95% confidence:

    (0.5-0.499741)/(0.5/sqrt(999999)) = 0.52 < 1.96

Using these statistics I would estimate a much larger number of
samples:

    num_samples > ((1.96*0.5)/(0.5-0.499741))**2

    num_samples > 14.3e6

Using a different simulation run, however, I achieve significance and
estimate a much lower number of samples:

    mean(sim_data) = 0.498731

    (0.5-0.498731)/(0.5/sqrt(1e6-1)) = 2.54 > 1.96

and

    num_samples > ((1.96*0.5)/(0.5-0.498731))**2

    num_samples > 0.6e6

The moral of the story -- Monte-Carlo simulations are hard when the
result is close to some critical value.  Conclusions about statistical
significance and number of samples may vary wildly with the results
of the simulation.


## Monte-Carlo Code

The run-time for 1e6 trials is ~9.5 seconds in Python and ~13.5 seconds in
R.

![Probability versus Number of People in Room](three_birthday_problem.png)


Python code sample:

    # Return P(less than 3 people with same birthday)
    def foo2(num_people=88, num_trials=1000000):
        n=0
        for i in range(num_trials):
            m=bincount(randint(1,366,num_people))
            if any(m>2):
                n=n+1
        p=1-n/num_trials
        return(p)

    In [196]: 1-foo2(87)
    Out[196]: 0.498822

    In [197]: 1-foo2(88)
    Out[197]: 0.51059


The generalized result is shown below:

![N Birthday Problem](N_birthday_problem.png)

## Direct Solution

This site has the best explanation of solving this problem and also provides
Python code: [Python Code for a direct solution](https://swarbrickjones.wordpress.com/2016/05/08/the-birthday-problem-ii-three-people-or-more/)
has been tested (see *three_birthday_combinatoric.py*).  This purportedly
corrects some errors in the *stackexchange* solutions noted above.  I have
looked at the stack exchange solutions (`birthday_stack.py`) and they
seem to work properly for the case of 3 birthdays (`birthday` and `birthday2`)
but the solution proposed by Trazom for the general case (`birthday3`) seems to
be wrong.  His solution works for M=3 but not for other values.  I have not
investigated to find out why this is broken.  The code, here, however works for
all tested combinations and the explanation seems correct.

To simplify (?) his explanation:  suppose we had a function that counted the
number of ways N items can be allocated into k bins with at most M items
in a bin.  Call this function F(M,N,k).  We don't know this function, but
we know a few things:

The probability that at least one of the bins has M or more items is:

    P = 1-F(M-1,N,365)/365^N

The value of F(M-1,N,365) is all the ways we can have less than M in a bin
so this is just the complementary probability.  This is what we are looking
for.  Consider the simplest case -- only one bin:

    For k=1 (e.g. one bin)
    F(M,N,1) = 1 for 0 <= N <= M and 0 elsewhere

Basically, if we have (up to) M items we can stuff them all in one bin.  If
we have more than M items then we can't stuff them into a bin because M is
the maximum we are allowed.  If we have negative items we can't stuff them into
a bin but I can't think of the physical meaning of this.

The final thing we know is:

    Assume the first bin contains m items with 0 <= m <= M
    There are C(N,m) ways to form this combination
    The remaining number of items is N-m
    The remaining number of bins is k-1
    The number of ways to combine the remaining items is F(M,N-m,k-1)

    If we add up all the different values of m we get:

    F(M,N,k) = Summation(C(N,m) * F(M,N-m,k-1), m=0, 1, ..., M)

This means we have a way to calculate F(...,k) from F(...,k-1).  If we start
with the case of k=1 we can then generate the results for k=2, k=3, ...,
all the way up to k=365 (the number of days in the year).

We need to keep storage for the current value of k and the new value of k.
Once the new value of k has been calculated it can replace the old.
The storage is a vector of 0, 1, 2, ..., N items.

We can populate the vector for the case k=1 (we know that).  Then we need to
update the vector and summation for k=2, 3, ..., 365 (e.g. only 364 updates).


The code on the website calculate F(M-1,N,365):

    The vector of N+1 items is initialized in current_row[]
    The outer loop runs 364 times by using d in range(1,365)
        n varies from 0 to N using range(N+1) to access all elements
            and update the vector in new_row[]

            m varies from 0 to M-1 using range(M) for the summation
                as m varies we accumulate the C(N,m)*F(M,N-m,k-1) values

        After new_row[] is complete put the results in current_row[]


    There is a subtlety in the m loop range: min(n+1,M).  This prevents
    the code from attempting to access F(m,n-m,k) for n-m < 0.  Note that
    this calculates F(M-1,...) since Python loops don't incude the end point.

When we get all done we can form the complementary probability:

    P = 1 - F(M-1,N,365)/365**2
    by accessing current_row[N]

The use of the Python decimal library makes most of the calculations easy
but they are not very fast as N,M get large.

The values produced by this code match the table of calculations given below
(at least up to 5 birthdays).  Unfortunately, the code blows up on problems
of 4 or more with:

    *OverflowError: math range error* when tested under Python 3:
    sys.version = 3.7.3 (default, Mar 27 2019, 17:13:21) [MSC v.1915 64 bit
    (AMD64)]).

I tracked this down to an overflow in calculating `365**N` when N gets
large.  I fixed this by using the Decimal value of 365 and the built-in
function `pow()` so it works now.  I confirmed the results against the
table up to the cases for 5 of the same birthday and the results agree
with the exception of the final digit for the case of three birthdays in
a group of 87.  The error is in the round-off of the final digit.

I think the original code was written in Python 2 (based on the print) but
I don't know if the original code ever worked for the more complex cases.
The only test case shown was 23,2 which worked on Python 3 as well

Even though this is a direct calculation of the results, the run time
starts to get appreciable for a large number of coincident birthdays.
For 5 birthdays the run time is ~ 16 seconds.  It is interesting to note
that the Monte Carlo simulation of the same case is only ~12.5 seconds
for 1e6 samples which is enough to demonstrate significance (Z~3).

Another Moral to the Story: sometimes Monte-Carlo is faster than direct
calculation.


# Other Resources

[Sequence giving solutions](http://oeis.org/A014088)



[Table of some exact calculations](http://oeis.org/A014088/a014088.txt)

Exact Solutions of the Generalized Birthday Problem 

Bruce Levin

   Assume N people are in a room.  What is the smallest N such that there
is at least probability 0.5 that M people have the same birthday?  Assume
the birthday distribution is uniform over 365 days.

   Assume X~Mult(N;P) on k=365 categories, with P=(1/365,...,1/365) and 
calculate Prob(M;N) = P[max X[i] is at least M] using the exact method of 
Levin, "A representation for multinomial cumulative distribution functions", 
Annals of Statistics, 9:1123-1126 (1981).

                M             N             Prob(M;N)
              -----         -----           ---------
                1             1             1
                1             0             0

                2            23             0.507297234324
                2            22             0.475695307663

                3            88             0.511065110625
                3            87             0.499454850632

                4           187             0.502685373189
                4           186             0.495825706383

                5           313             0.501070475849
                5           312             0.496195571644

                6           460             0.50244941037
                6           459             0.498637523705

                7           623             0.502948948663
                7           622             0.499795687887

                8           798             0.500320275207
                8           797             0.497616714463

                9           985             0.500948416378
                9           984             0.498568067031

               10          1181             0.500931161057
               10          1180             0.498796176416

               11          1385             0.501001958747
               11          1384             0.499059528126

               12          1596             0.501166734721
               12          1595             0.499379622274

               13          1813             0.501104224633
               13          1812             0.499445407288

               14          2035             0.500348626509
               14          2034             0.498798065243

               15          2263             0.501295448239
               15          2262             0.499836197505

