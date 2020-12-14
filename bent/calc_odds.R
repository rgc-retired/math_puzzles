library(gmp)

calc_odds = function(n) {
    #
    # sum of two die
    ddd=outer(1:6,1:6,"+")
    # Probability on fair die
    p1=rep(as.bigq(1,6),6)
    # Probability on loaded die
    # All sides are the same (2/15) except for
    # the loaded side which is 1/3
    p2=rep(as.bigq(2,15),6); p2[n]=as.bigq(1,3)
    #
    # Probability of rolling a particular combination
    zzz=rep(as.bigq(0),12)
    for (i in 2:12) { zzz[i] = sum((ddd==i)*outer(p1,p2,"*"))}
    # Win requires a 7 or 11 or making a point
    # Making a point depends on Pr(point) versus Pr(point or 7)
    points=c(4,5,6,8,9,10)
    # Probability of rolling a point
    p_point=zzz[points]
    # Probability of winning a point versus getting a 7
    p_win_point=zzz[points]/(zzz[points]+zzz[7])
    # Total probability of winning any of the 6 points
    p_win_any_point=sum(p_point*p_win_point)
    Pr=zzz[7]+zzz[11]+p_win_any_point
    return(Pr)
}

monte_odds = function(n=5,n_trials=100000) {
    n_wins=0
    p2=rep(1/6,6)
    if (n != 0) { p2=rep(2/15,6); p2[n]=1/3 }
    # first_roll=rep(0,n_trials)
    for (trial in 1:n_trials) {
        d1=sample(1:6,1)
        d2=sample(1:6,1,prob=p2)
        t=d1+d2
        # first_roll[trial]=t
        if ( (t==7) | (t==11) ) {
            n_wins=n_wins+1
        } else {
            if ( (t==2) | (t==3) | (t==12) ) {
                # you lose
            } else {
                point_to_make=t
                while (T) {
                    d1=sample(1:6,1)
                    d2=sample(1:6,1,prob=p2)
                    t=d1+d2
                    if (t==7) {
                        break
                    } else {
                        if (t==point_to_make) {
                            n_wins=n_wins+1
                            break
                        }
                    }
                }
            }
        }
    }
    xxx=list()
    xxx$n_wins=n_wins
    xxx$n_trials=n_trials
    # xxx$first_roll=first_roll
    return(xxx)
}

