import numpy as np
import pandas as pd

# Honeycomb = NANCYLM
# 
#    word  word_score  total_score
#    alma           1            1
#    amyl           1            2
#    calm           1            3
#    clam           1            4
#    cyma           1            5
#    lama           1            6
#    mall           1            7
#    malm           1            8
#    mama           1            9
#    mana           1           10
#    many           1           11
#    maya           1           12
#    myna           1           13
#   llama           5           18
#   malmy           5           23
#   mamma           5           28
#   mammy           5           33
#   manly           5           38
#   manna           5           43
#   mayan           5           48
#  calmly           6           54
#  cayman           6           60
#  clammy           6           66
#  layman           6           72
#  mammal           6           78
#  manana           6           84
#  mannan           6           90
# almanac           7           97
# malacca           7          104

def read_dict(fname="enable1.txt"):
    d=[i.rstrip() for i in open(fname).readlines()]
    return(d)

def prune_dict(d,min_length=4):
    return([i for i in d if len(i)>=min_length])

def solve_honeycomb(h,d):
    zzz=[]
    for a in d:
        if all([i in h for i in a]):
            if h[-1] in a:
                zzz.append(a)
    zzz.sort(key=lambda x: (len(x),x))
    return(zzz)

def score_honeycomb(h,zzz):
    www=[]
    score=0
    for a in zzz:
        bonus=0
        if (len(np.unique([i for i in a]))==7):
            bonus=7
        if len(a)<=4:
            word_score=1
        else:
            word_score=len(a)+bonus
        score=score+word_score
        if bonus==7:
            www.append([a+" *",word_score,score])
        else:
            www.append([a,word_score,score])
    return(www)

if __name__ == "__main__":
    d=read_dict()
    nyt=prune_dict(d,4)
    # Typical usage for a NYT style puzzle with min word
    # length of 4 letters - must use the "center" letter
    # in all words.  This is specified as the last letter
    # in the letterset string.
    #
    # h='set_of_letters'
    # wordlist=solve_honeycomb(h,nyt)
    # scores=score_honeycomb(h,wordlist)
    # df=pd.DataFrame(scores,columns=["word","score","total"]

