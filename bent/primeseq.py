import sympy

# Used this to search for all sequences below 1e9.
# There are 8 sequences of length 13 or more with differences of
# 8 or less between successive primes.  The first prime in each
# sequence along with the sequence lengths are given here:
#
# In [616]: find_sequence(1,1_000_000_000,8,13)
#
#    First prime   Length
#    --------------------
#    2             30
#    2657          14
#    14713         13
#    86966771      13
#    172039573     13
#    296931731     13
#    369008657     13
#    875753231     13
#
# Some more details
#
#    FirstPrime  SeqLength  LastPrime  DeltaPrime  MeanDiff
# 0           2         30        113         111  3.827586
# 1        2657         14       2719          62  4.769231
# 2       14713         13      14783          70  5.833333
# 3    86966771         13   86966833          62  5.166667
# 4   172039573         13  172039633          60  5.000000
# 5   296931731         13  296931797          66  5.500000
# 6   369008657         13  369008729          72  6.000000
# 7   875753231         13  875753299          68  5.666667
#
#
# The runtime is substantial (about an hour) with the first
# three found almost instantly and the rest taking proportionally
# longer.
#
# FYI: the last value is sympy.prime(44833217) where sympy.prime(1)=2
#

def find_sequence(nstart=2,nstop=1000,maxdiff=8,minlength=13):
    """
    Search for sequences of prime numbers that meet the following
    criteria:
    
    difference between successive primes <= maxdiff
    length of sequence >= minlength
    
    Output the first prime in each sequence and the sequence length
    """
    zzz=[]
    lastprime=-1000
    firstprime=0
    seqlen=1
    for i in sympy.primerange(nstart,nstop):
        if (i-lastprime)<=maxdiff:
            seqlen=seqlen+1
        else:
            # Found the end of a sequence
            # If the last sequence was long enough then output the specs
            if seqlen>=minlength:
                print(firstprime,seqlen)
                zzz.append([firstprime,seqlen])
            seqlen=1
            firstprime=i
        lastprime=i
    # Process any sequence that is in progress when the loop ends
    if seqlen>=minlength:
        print(firstprime,seqlen)
        zzz.append([firstprime,seqlen])
    return(zzz)

