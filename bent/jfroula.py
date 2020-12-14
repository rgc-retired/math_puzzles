import itertools

#  Cryptic in Base 12 with constraint
#
#      J * FROULA = RETIRE * S
#
#      REST should have maximum value

# Unique symbols are:  jfroulaetis (11 symbols)

def make_num(a,s,num_base=10):
    """
    Given a dictionary of symbol values with symbol as the key
    Given a string representing a number
    Given the number base

    Convert string in s to number using dictionary in a and num_base
    """
    n=0
    for i in s:
        n=num_base*n+a[i]
    return(n)

a=dict()
n=0
print('  j  f  r  o  u  l  a  e  t  i  s')
for i in itertools.permutations(range(12),11):
    a['j'],a['f'],a['r'],a['o'],a['u'],a['l'],a['a'],a['e'],a['t'],a['i'],a['s'] = i
    if (a['j']==0) or (a['f']==0) or (a['r']==0) or (a['s']==0):
        continue
    n1=make_num(a,'j',12)*make_num(a,'froula',12)
    n2=make_num(a,'retire',12)*make_num(a,'s',12)
    if n1==n2:
        print(("%3d"*11) % i)
    n=n+1

