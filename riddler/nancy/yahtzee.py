import numpy as np

# Attempt to get a large straight after
# first roll result = 1, 2, 4, 5, X where
# X is not a 3.
#
# What is the optimal strategy to get a large straight?
# This is either 1-2-3-4-5 or 2-3-4-5-6.  No other result
# matters.
#
# Possibilities:
# --------------
# 1. Reroll the X to try for inside straight (e.g. 3)?
# 2. Reroll the 1 and X?
# 3. Other?

# Strategy 1: Reroll the X only
def strategy1():
    r=np.array([1,2,4,5])
    s=np.random.choice(6,1)+1
    a=np.r_[r,s]
    a=np.sort(a)
    if np.all(a==np.array([1,2,3,4,5])):
        return(True)
    s=np.random.choice(6,1)+1
    a=np.r_[r,s]
    a=np.sort(a)
    if np.all(a==np.array([1,2,3,4,5])):
        return(True)
    return(False)

# Strategy 3: Reroll the 1,X
# Reroll 1 die if you have a 3, 1, or 6
# The priority is to keep the 3 (double ended straight)
def strategy3():
    r=np.array([2,4,5])
    s=np.random.choice(6,2)+1
    a=np.r_[r,s]
    a=np.sort(a)
    if np.all(a==np.array([1,2,3,4,5])):
        return(1)
    elif np.all(a==np.array([2,3,4,5,6])):
        return(1)
    # First roll failed -- need to figure out
    # what to try on the second roll.
    # If none of the new dice are 1, 3, or 6 then
    #    roll them both again.
    # elif either of the new dice is 3 then keep it
    #    roll other die - 2 chances to win
    # elif either of the new dice is 1 then keep it
    #    roll other die - 1 chance to win
    # elif either of the new dice is 6 then keep it
    #    roll other die - 1 chance to win
    if 3 in s:
        # Keep the 3 and roll the other die
        r=np.array([2,3,4,5])
        s=np.random.choice(6,1)+1
        rollpath=2
    elif 1 in s:
        # Keep the 1 and roll the other die
        r=np.array([1,2,4,5])
        s=np.random.choice(6,1)+1
        rollpath=3
    elif 6 in s:
        # Keep the 6 and roll the other die
        r=np.array([2,4,5,6])
        s=np.random.choice(6,1)+1
        rollpath=4
    else:
        # Roll both dice
        r=np.array([2,4,5])
        s=np.random.choice(6,2)+1
        rollpath=5
    a=np.r_[r,s]
    a=np.sort(a)
    if np.all(a==np.array([1,2,3,4,5])):
        return(rollpath)
    elif np.all(a==np.array([2,3,4,5,6])):
        return(rollpath)
    return(0)

# Strategy 2: Reroll the 1,X
# Roll 1 die if you have a 3 otherwise roll 2
def strategy2():
    r=np.array([2,4,5])
    s=np.random.choice(6,2)+1
    a=np.r_[r,s]
    a=np.sort(a)
    if np.all(a==np.array([1,2,3,4,5])):
        return(1)
    elif np.all(a==np.array([2,3,4,5,6])):
        return(1)
    # First roll failed -- need to figure out
    # what to try on the second roll.
    # If none of the new dice are 1, 3, or 6 then
    #    roll them both again.
    # elif either of the new dice is 3 then keep it
    #    roll other die - 2 chances to win
    # elif either of the new dice is 1 then keep it
    #    roll other die - 1 chance to win
    # elif either of the new dice is 6 then keep it
    #    roll other die - 1 chance to win
    if 3 in s:
        # Keep the 3 and roll the other die
        r=np.array([2,3,4,5])
        s=np.random.choice(6,1)+1
        rollpath=2
    else:
        # Roll both dice
        r=np.array([2,4,5])
        s=np.random.choice(6,2)+1
        rollpath=5
    a=np.r_[r,s]
    a=np.sort(a)
    if np.all(a==np.array([1,2,3,4,5])):
        return(rollpath)
    elif np.all(a==np.array([2,3,4,5,6])):
        return(rollpath)
    return(0)

