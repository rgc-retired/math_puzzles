# A Monte-Carlo solution to getting a large straight in Yahtzee.
#
# I wrote this to attempt to break a disagreement between a
# Monte-Carlo routine from Python and an analytical solution
# I created.  Now I have three different answers and I don't
# know what to believe!!!!!  After a lot of messing around
# and finding errors in the analysis and R sample function I
# think everything makes sense now.
#
# Problem: Attempt to get a large straight (1,2,3,4,5 or 2,3,4,5,6)
#   On the first roll you have (1,2,4,5,X) where X is not 3.
#
# Strategy 1: Take the X and roll in attempt to get a 3.  If you
# get a 3 then you win.  If not, roll again and attempt to get a
# final 3, if so then you win.  If not, then you lose.  This is
# relatively simple and the analytical solution is that you win
# with a probability of 1-(5/6)^2 = 11/36 ~ 0.30556.
#
# The analytical and Monte-Carlo from Python agree on this.  The
# Monte-Carlo from R also agrees with this.  Hooray.
#
# Strategy 2: Take the X and the 1 which leaves (2,4,5).  Roll them
# both and try for: 1-3, 3-1, 3-6, or 6-3.  If you get any of these
# you win (P1 = 4/36 ~ 0.1111).
#
# If you don't win (P=32/36) but either of the dice is a 3 then keep
# it and roll the one remaining die.  This leaves you with a double
# ended straight possibility (2,3,4,5) so a roll of 1 or 6 will win.
# You only roll one die so the probability is 2/6.
#
# This is where my analysis was flawed -- need to figure out the
# correct probability for a 3.  Some of the threes are consumed
# by the previous step when you actually win so the likelihood of
# a three here is smaller than I originally calculated.
#
# I used a value of 11/36 but it should have been (11-4)/36 or
#
#    P2 = 7/36 * 2/6 = 7/108 ~ 0.064815
#
# Finally, if no 3 is rolled, then roll both dice again.  This should
# occur 25/36 of the time and have a success probability of 4/36.
# The overall probability for this should be:
#
#  P3 = 25/36 * 4/36 = 25/324 ~ 0.077160
#
# Total P = P1+P2+P3 = 41/162 ~ 0.253086
#   Loss = 1-P  ~ 0.746914
#   P1 = 1/9    ~ 0.111111
#   P2 = 7/108  ~ 0.064815
#   P3 = 25/324 ~ 0.077160
#
# Summary of Results (1e6 trials):
#
#         Strategy 1               Strategy 2
# Seed    Analytical   MC          Analytical   MC
# ------------------------------------------------------
# Unknown 0.305556     0.305422    0.253086     0.253199
# 1                    0.305816                 0.25294
# 42                   0.305388                 0.253079
# 123                  0.305394                 0.253333
# 2020                 0.305478                 0.252928
#
# Examining the individual parts of strategy2
#
# For Monte-Carlo
#
# Using R:
#
# Seed   Loss     P1       P2       P3
# ------------------------------------------
# 1      0.74706  0.110900 0.064314 0.077726
# 42     0.746921 0.111551 0.064548 0.076980
# 123    0.746667 0.111068 0.064914 0.077351
# 2020   0.747072 0.110636 0.065103 0.077189
#
# Using Python:
# 
# Seed   Loss     P1       P2       P3
# ------------------------------------------
# 1     0.746806  0.111548 0.064707 0.076939 
# 42    0.747006  0.110882 0.06457  0.077542 
# 123   0.74698   0.111669 0.064776 0.076575 
# 2020  0.746276  0.111789 0.064934 0.077001
#
# Of course the meaning of seed is completely different
# between the two languages but they all seems to
# give about the same (correct) results.


strategy1 = function() {
    r=c(1,2,4,5)
    s=sample(6,1)
    a=c(r,s)
    a=sort(a)
    if (all(a==c(1,2,3,4,5)) | all(a==c(2,3,4,5,6))) {
        return(1)
    }
    s=sample(6,1)
    a=c(r,s)
    a=sort(a)
    if (all(a==c(1,2,3,4,5)) | all(a==c(2,3,4,5,6))) {
        return(2)
    }
    return(0)
}

strategy2 = function() {
    r=c(2,4,5)
    s=sample(6,2,replace=TRUE)
    a=c(r,s)
    a=sort(a)
    if (all(a==c(1,2,3,4,5)) | all(a==c(2,3,4,5,6))) {
        return(1)
    }
    if (any(s==3)) {
        r=c(2,3,4,5)
        s=sample(6,1)
        a=c(r,s)
        a=sort(a)
        if (all(a==c(1,2,3,4,5)) | all(a==c(2,3,4,5,6))) {
            return(2)
        } else {
            return(-2)
        }
    } else {
        r=c(2,4,5)
        s=sample(6,2,replace=TRUE)
        a=c(r,s)
        a=sort(a)
        if (all(a==c(1,2,3,4,5)) | all(a==c(2,3,4,5,6))) {
            return(3)
        } else {
            return(-3)
        }
    }
}
    
