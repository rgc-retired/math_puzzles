
# sock_matching --------------------------------------------------------

ntrials=1000000

socks=rep(1:10,each=2)

set.seed(2020)

n=0
for (trial in 1:ntrials) {
  s=sample(socks)
  for (i in seq_along(s)) {
    m=i
    if (length(unique(s[1:i]))<i) { break }
  }
  n=n+m
}
n/ntrials


# gummy ----------------------------------------------------------------

ntrials=100000

set.seed(2020)
m=rep(0,ntrials)
for (trial in seq_along(m)) {
  vitamins=rep(1:2,each=30)
  favorites=0
  for (i in 1:15) {
    s=sample(length(vitamins),4)
    if (sum(vitamins[s]==1)==0) {
      # I don't get any of my favorites
      favorites=favorites+0
    } else if (sum(vitamins[s]==1)==1) {
      # I get one of my favorites
      favorites=favorites+1
    } else {
      # I get two of my favorites
      favorites=favorites+2
    }
    vitamins=vitamins[-s]
  }
  m[trial]=favorites
}


# pill-splitter -----------------------------------------------------------

ntrials=100000

set.seed(2020)
n=0
for (trial in 1:ntrials) {
  # Start out with 100 full tables
  bottle=rep(2,100)
  prob=rep(2,100)
  while (TRUE) {
    n=n+1
    s=sample(1:100,1,prob=prob)
    if (bottle[s]==1) { break }
    bottle[s]=1
    prob[s]=1
  }
}
n/ntrials


# birthday-candles --------------------------------------------------------

ntrials=100000
set.seed(42)

a=c()
t=c()
for (age in c(1,2,3,4,5,6,8,10,12,14,16,18,20,25,30,40,50,60,70,80,90,100)) {
  n=0
  for (trial in 1:ntrials) {
    candles=age
    while (TRUE) {
      s=sample(candles,1)
      n=n+1
      candles=candles-s
      if (candles == 0) { break }
    }
  }
  a=append(a,age)
  t=append(t,n/ntrials)
}
df=data.frame(age=a,tries=t)
df
