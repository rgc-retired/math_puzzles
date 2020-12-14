
## 2020-01-03 Word-Puzzle

[Problem](https://fivethirtyeight.com/features/can-you-solve-the-vexing-vexillology/)

    Riddler Classic

    The New York Times recently launched some new
    word puzzles, one of which is Spelling Bee.
    In this game, seven letters are arranged in a
    honeycomb lattice, with one letter in the
    center. Here's the lattice from December 24,
    2019:

            A
         L     P
            G
         E     X
            M

    The goal is to identify as many words that
    meet the following criteria:

    1. The word must be at least four letters long.
    2. The word must include the central letter.
    3. The word cannot include any letter beyond the
       seven given letters.

    Note that letters can be repeated. For
    example, the words GAME and AMALGAM are both
    acceptable words.  Four-letter words are
    worth 1 point each, while five-letter words
    are worth 5 points, six-letter words are
    worth 6 points, seven-letter words are worth
    7 points, etc.  Words that use all of the
    seven letters in the honeycomb are known as
    "pangrams" and earn 7 bonus points (in
    addition to the points for the length of the
    word). So in the above example, MEGAPLEX is
    worth 15 points.

    Which seven-letter honeycomb results in the
    highest possible game score? To be a valid
    choice of seven letters, no letter can be
    repeated, it must not contain the letter S
    (that would be too easy) and there must be at
    least one pangram.

    For consistency, please use this word list to
    check your game score.2

[word list](https://norvig.com/ngrams/enable1.txt)

[Solution](https://fivethirtyeight.com/features/can-you-find-a-number-worth-its-weight-in-letters/)

    RGC: Done

**See the file `nancy.py` for a program to make/solve these**

    For the maximum scoring set: aegintr

    Score = 3898
    Total words = 537
    There are 50 pangrams
    Max word score = 20 (reaggregating, reintegrating)

    Point distribution

    Score   Words
    -------------
    1       46
    5       81
    6       117
    7       126
    8       59
    9       32
    10      18
    11      6
    12      1
    13      1
    14      5
    15      5
    16      15
    17      11
    18      8
    19      4
    20      2

    For the most common letters: etaonis

    Score = 4422
    Total words = 644
    Total pangrams = 19
    Max word score = 21 (sensitisations)

    Point distribution

    Score   Words
    -------------
    1       79
    5       108
    6       105
    7       103
    8       95
    9       65
    10      29
    11      22
    12      9
    13      6
    14      3
    15      5
    16      3
    17      2
    18      3
    19      5
    20      1
    21      1

## 2019-12-20 Matching Socks

[Problem](https://fivethirtyeight.com/features/can-you-find-a-matching-pair-of-socks/)

    Riddler Classic

    From Kathy Bischoping comes a question we've
    all asked ourselves at one time or another:

    I have 10 pairs of socks in a drawer. Each
    pair is distinct from another and consists of
    two matching socks. Alas, I'm negligent when
    it comes to folding my laundry, and so the
    socks are not folded into pairs. This
    morning, fumbling around in the dark, I pull
    the socks out of the drawer, randomly and one
    at a time, until I have a matching pair of
    socks among the ones I've removed from the
    drawer.

    On average, how many socks will I pull out of
    the drawer in order to get my first matching
    pair?

    (Note: This is different from asking how many
    socks I must pull out of the drawer to
    guarantee that I have a matching pair. The
    answer to that question, by the pigeonhole
    principle, is 11 socks. This question is
    instead asking about the average.)

    Extra credit: Instead of 10 pairs of socks,
    what if I have some large number N pairs of
    socks?

[Solution](https://fivethirtyeight.com/features/can-you-solve-the-vexing-vexillology/)

    RGC: Done

    Should be pretty straight-forward with Monte Carlo.

    ntrials = 1e6

    Seed    Mean draw
    --------------------
    42      5.677329
    123     5.673842
    2020    5.673913

    Looks pretty consistent ~ 5.67 (or so) socks on average.

    The analytical approach gets messed up with the conditional
    probabilities.

    You get a telescoping of terms for each additional sock
    you have to draw.

    The Riddler gives a solution of 4^n/choose(2*n,n) where
    n = number of pairs of socks.  They also point out the
    remarkable agreement with sqrt(pi*n).

## 2019-10-04 Riddler Millionaire

[Problem](https://fivethirtyeight.com/features/who-wants-to-be-a-riddler-millionaire/)

    Riddler Express

    From Thomas Sneller comes a puzzle that
    brings us back to the game show to end all
    game shows, "Who Wants to Be a Riddler
    Millionaire?" As you'll remember, for each
    question you must pick the correct option
    from four choices.

    You've made it to the $1 million question,
    but it's a tough one. Out of the four
    choices, A, B, C and D, you're 70 percent
    sure the answer is B, and none of the
    remaining choices looks more plausible than
    another. You decide to use your final
    lifeline, the 50:50, which leaves you with
    two possible answers, one of them correct. Lo
    and behold, B remains an option! How
    confident are you now that B is the correct
    answer?

[Solution](https://fivethirtyeight.com/features/can-you-escape-the-enemy-submarines/)

    RGC: Done

    Should be Bayes Theorem: P(A|B) = P(B|A)*P(B)/P(A)

    Should also be able to enumerate the possibilities
    assuming B is wrong but remains by random chance.

    If I was 70% sure it was B then I was only 10% sure
    It was A, C, or D.

    After the 50-50 I am still 7x more sure it is B than
    the other choice so I am 7/8 sure ~ 87.5%    


## 2018-09-07 Riddler Millionaire

[Problem](https://fivethirtyeight.com/features/id-like-to-use-my-riddler-lifeline/)

    Riddler Express

    From Tom Hanrahan, some big-money game show
    strategizing:

    You are a contestant on "Who Wants to Be a
    Riddler Millionaire." You have already made
    it to a late round: You could walk away right
    now with $250,000. But there are two
    potential questions still to go that you can
    try to answer. You could earn $500,000 if you
    get one right and then walk away, or $1
    million if you nail them both. If you attempt
    any answer and miss, you go home with
    $10,000.

    Luckily, you still have two of your
    lifelines:

    * The 50/50: The host reduces the four possible
      answers to two; one of them is the correct
      one and the other is randomly chosen from
      among the other three answers.

    * Ask the Audience: The studio audience submits
      their own guesses. You know historically that
      the correct answer will be chosen by the
      plurality 50 percent of the time; while 30
      percent of the time the right answer finishes
      second; 15 percent third; and 5 percent last.
      Additionally, if there are only two answers
      available to the audience, they pick the
      correct one more often 65 percent of the
      time.

    The problem: You're burned out. All the
    pressure and questions you've already
    answered have made you a babbling mess. You
    assess that you would have no clue on the
    last two questions, so you'll be guessing
    randomly.

    What is your best strategy to play, or stop,
    or use your lifelines to maximize your
    expected winnings?

[Solution](https://fivethirtyeight.com/features/to-solve-the-eccentric-billionaires-puzzle-you-must-first-defeat-the-banker/)

    RGC: TODO

    From the Riddler solution:

    So to summarize, your best strategy is to use your Ask the
    Audience, then use your 50/50, then guess at the $500,000
    question. If you get that one right, just walk away.


## 2018-09-07 Card Collector

[Problem](https://fivethirtyeight.com/features/id-like-to-use-my-riddler-lifeline/)

    Riddler Classic

    From Jerry Meyers, a conundrum timed to kick
    off the football season!

    My son recently started collecting Riddler
    League football cards and informed me that he
    planned on acquiring every card in the set.
    It made me wonder, naturally, how much of his
    allowance he would have to spend in order to
    achieve his goal. His favorite set of cards
    is Riddler Silver; a set consisting of 100
    cards, numbered 1 to 100. The cards are only
    sold in packs containing 10 random cards,
    without duplicates, with every card number
    having an equal chance of being in a pack.

    Each pack can be purchased for $1. If his
    allowance is $10 a week, how long would we
    expect it to take before he has the entire
    set?

    What if he decides to collect the more
    expansive Riddler Gold set, which has 300
    different cards?

[Solution](https://fivethirtyeight.com/features/to-solve-the-eccentric-billionaires-puzzle-you-must-first-defeat-the-banker/)

    RGC: Done

    Monte Carlo

    Number of packs required to get all 100 cards

    100K Monte Carlo trials in Python
    mean = 49.9767
    std  = 11.98
    quantiles = [ 22.,  41.,  48.,  56., 152.]

    I imagine it scales linearly with number of cards
    but I don't really know so I will also run 100K trials
    with the 300 card collection

    mean = 186.01875
    std  = 37.66
    quantiles = [100., 159., 180., 206., 500.] 


## 2018-03-09 Yahtzee 1

[Problem](https://fivethirtyeight.com/features/are-you-the-perfect-yahtzee-player/)

    Riddler Express

    Let's warm up with a bit of Yahtzee gameplay
    calculation:

    Suppose that you're playing a one-turn game
    of Yahtzee, in which your only consideration
    is maximizing your score on this single turn.
    (In Yahtzee, a player has up to three rolls
    of five dice to get various combinations of
    numbers, which earn the player different
    numbers of points.) After your second of
    three rolls, your five dice show 4, 4, 4, 5
    and 5. You could keep all of your dice and
    score 25 points for a full house. Or you
    could reroll your 5s and try for the 50-point
    Yahtzee (which is when all five dice show the
    same number) - but then you'd run the risk of
    scoring a lowly three- or four-of-a-kind
    instead, which are worth the sum of your five
    dice.

    What's the best strategy for maximizing your
    expected score?

[Solution](https://fivethirtyeight.com/features/can-you-do-math-with-shapes/)

    RGC: Done

    Monte Carlo

    Seems pretty clear that you should just keep the
    full house.  May also be able to do this analytically:

    Final Roll results (a,b != 4)

    D1  D2  P                Result
    -------------------------------------
    4   4   1/6*1/6 = 1/36   Yahtzee
    4   a   1/6*5/6 = 5/36   4 of a kind
    a   4   5/6*1/6 = 5/36   4 of a kind
    a   a   5/6*1/6 = 5/36   Full House
    a   b   5/6*4/6 = 20/36  3 of a kind

    With Yahtzee: score=50
    With full house: score=25
    With 4 of a kind the mean score should be 4*4 + mean(1,2,3,5,6)
        = 16+17/5
        = 19.4
    With 3 of a kind the mean score should be 4*3+2*mean(1,2,3,5,6)
        = 12+2*17/5
        = 18.8

    Final result:

        Mean Score = 50*1/36 + 25*5/36 + 19.4*10/36 + 18.8*20/36
                   = 20.69444

    Monte-Carlo results of 100K trials - 10 repetitions

    Mean = 20.693578
    Std  = 0.0153664

    Trial results:

    [20.6863 , 20.71572, 20.69018, 20.71209, 20.67149,
     20.70931, 20.687  , 20.67864, 20.68195, 20.7031 ]

    Code:

        www=[]
        for trial in range(10):
            score=0
            for i in range(100000):
                s=choice(6,2)+1
                a=r_[r,s]
                if len(unique(a))==1:
                    score=score+50
                elif a[3]==a[4]:
                    score=score+25
                else:
                    score=score+sum(a)
            score=score/100000
            print(score)
            www.append(score)
        www=array(www)

## 2018-03-09 Yahtzee 2

[Problem](https://fivethirtyeight.com/features/are-you-the-perfect-yahtzee-player/)

    Riddler Classic

    From Zeke Steve, a puzzle inspired by a
    familial dispute over proper game night
    strategy:

    It's your final turn in a heated game of
    Yahtzee, and the only combination of dice you
    still need to score is a large straight (when
    all five dice show numbers in sequential
    order): You want your five dice to eventually
    show 1, 2, 3, 4 and 5 or 2, 3, 4, 5 and 6. On
    the first of your three possible rolls during
    your final turn, you roll 1, 2, 4, 5 and X
    (where X is not a 3). You could reroll the X
    in hopes of getting a 3. Or you could reroll
    the 1 and the X in hopes that they eventually
    land in some combination of 3 and 6. Or
    perhaps something completely different!

    What's the best strategy for hitting a large
    straight and winning the game?

[Solution](https://fivethirtyeight.com/features/can-you-do-math-with-shapes/)

    RGC: Done

    Monte-Carlo (1e6 trials)

    Just roll 1: 0.305917
    Roll 2:      0.253199

    Should be able to do the first strategy analytically.
    The odds of missing twice is (5/6)^2 so the odds of
    success are just 1-(5/6)^2.

    1-(5/6)**2 = 11/36 ~ 0.305556

    The second strategy?

    The odds of getting what we need on the first toss?
    We are keeping [2,4,5].  Rolling [1,X].

    There are 36 possibilities.

    We win if we roll: 1-3, 3-1, 3-6, 6-3

    This is P1 = 4/36

    The other 32/36 possibilities depend on what we roll
    and what we keep.  If neither die is a 3 then we have
    the same condition as the start.  The probability that
    neither of the two die is a 3 is 5/6*5/6 = 25/36.  If
    this occurs then the second roll will result in rolling
    both dice and the same probability of winning.

        P3 = 25/36 * 4/36

    If at least one of the die is a 3 then we can keep it
    and only roll one starting with [2,3,4,5].  There are
    only 7 ways this can occur (4 of the 3-x combinations
    were used up in the wins above).  With the remaining
    7/36 cases where we have a 3 we can roll one die.

    This die can come up 1 or 6 for a win.

        P2 = 7/36 * 2/6

    If neither is a 3 but one is either a 1 or a 6 ...
    there is a slight advantage to keeping a 1 or a 6 and
    then going for a 3 (1/6 versus 4/36) but I will ignore
    that for now.  The Riddler website uses that to improve
    to about 0.279 but it is still less than 0.30556.

    The total possiblity of winning is then:

        P = 4/36 + 25/36*4/36 + 7/36*2/6
          = 41/162
          ~ 0.2530864

    Alternately, the probability of a loss is:

        1-P = 121/162 ~ 0.7469136
   
    This seems to agree with the Monte-Carlo results.  I had
    to fight through errors in the analysis and then I forgot
    that the R sample function default is to not use replacements
    so that was messed up ... in general a lot of work to finally
    get to a relatively simple answer:

        P = 0.253 if you reroll 1-X and then only roll 1 die after
                  the second roll if you have a small straight.

    As noted above, a very small improvement can occur if you have
    the chance to draw to an inside straight after the second
    roll but it won't be enough to make a big difference.

    Could also roll 3 dice in an attempt to get to a small straight and then
    have a double ended chance at a big straight.

## 2018-02-02 Gummy Vitamins

[Problem](https://fivethirtyeight.com/features/will-the-grasshopper-land-in-your-yard/)

    Riddler Express

    From Diarmuid Early, a daily dose puzzle:

    You and your spouse each take two gummy
    vitamins every day. You share a single bottle
    of 60 vitamins, which come in two flavors.
    You each prefer a different flavor, but it
    seems childish to fish out two of each type
    (but not to take gummy vitamins). So you just
    take the first four that fall out and then
    divide them up according to your preferences.
    For example, if there are two of each flavor,
    you and your spouse get the vitamins you
    prefer, but if three of your preferred flavor
    come out, you get two of the ones you like
    and your spouse will get one of each.

    The question is, on average, what percentage
    of the vitamins you take are the flavor you
    prefer? (Assume that the bottle starts out
    with a 50-50 split between flavors, and that
    the four selected each day are selected
    uniformly at random.)

[Solution](https://fivethirtyeight.com/features/will-your-picture-frame-come-crashing-to-the-floor/)

    RGC: Done

    Monte-Carlo

    Start with 60 pills and pull out 4 per day for 15 days.
    What percentage of the vitamins you take are the flavor
    you want?

    Seed   Summary(Favorites)
           Min     1st Qu  Median  Mean    3rd Qu. Max.
    -----------------------------------------------------
    42     0.6333  0.8000  0.8333  0.8188  0.8333  0.9667
    123    0.6333  0.8000  0.8333  0.8190  0.8333  1.0000 
    2020   0.6333  0.8000  0.8333  0.8190  0.8333  1.0000

    You get what you want about 82% of the time?  Seems high.


    @@@
    Nancy problem: she likes two out of three, 70 in bottle.
    She gets two and Louis gets two.


## 2017-10-27 The Price is Right

[Problem](https://fivethirtyeight.com/features/can-you-play-the-price-is-right-perfectly/)

    Riddler Classic

    From Jason Margiotta, a puzzle about spinning
    the big wheel:

    On the brilliant and ageless game show "The
    Price Is Right," there is an important
    segment called the Showcase Showdown. Three
    players step up, one at a time, to spin an
    enormous, sparkling wheel. The wheel has 20
    segments at which it can stop, labeled from 5
    cents up to $1, in increments of 5 cents.
    Each player can spin the wheel either one or
    two times.  The goal is for the sum of one's
    spins to get closer to $1 than the other
    players, without going over.  (Any sum over
    $1 loses. Ties are broken by a single spin of
    the wheel, where the highest number
    triumphs.)

    For what amounts should the first spinner
    stop after just one spin, assuming the other
    two players will play optimally?

[Solution](https://fivethirtyeight.com/features/can-you-pick-up-sticks-can-you-help-a-frogger-out/)

    RGC: TODO

    Might be able to do this analytically ... but ... it
    gets complicated.

    I looked at the solution on the Riddler.  It is quite
    complicated and they don't really solve it in the column.
    They reference computer programs, decision tables, and a
    paper.

    Basic result: First person should spin again iff they have < 70.

## 2017-10-13 This is Jeopardy!

[Problem](https://fivethirtyeight.com/features/how-much-is-a-perfect-game-of-jeopardy-worth/)

    Riddler Express

    From Dean Arvidson, I'll take a math problem
    for $200, Alex:

    Austin Rodgers is having quite a run on the
    game show "Jeopardy!" As The Riddler goes to
    press, he's won $411,000 over 12 days. What's
    the maximum amount of money that can possibly
    be won by one contestant in a single game of
    "Jeopardy!"?

[Solution](https://fivethirtyeight.com/features/can-you-please-the-oracle-can-you-escape-the-prison/)

    RGC: Done

    Should be able to enumerate this.

    For single Jeopardy we want the Daily Double to be
    under a $200 question and we want to answer all the
    questions before we get there and then double the total.

    Each category is 200,400,600,800,1000 = $3000
    There are six categories = $18000-$200 = $17800
    Double it for a total of $35600 at end of Single Jeopardy.

    For Double Jeopardy, want the two daily doubles to come
    up last under the $400 questions.

    Each category is 400,600,1200,1600,2000 = $6000.
    There are six categories = $36000 - 2*$400 = $35200
    Add this to the single Jeopardy total = $70800

    Double this twice = $283200

    Double in Final Jeopardy = $566400 (maximum possible total)

## 2017-08-25 Pill Splitter

[Problem](https://fivethirtyeight.com/features/work-a-shift-in-the-riddler-gift-shop/)

    Riddler Express

    From Alex Vornsand, a puzzle for your daily
    routine:

    You take half of a vitamin every morning. The
    vitamins are sold in a bottle of 100 (whole)
    tablets, so at first you have to cut the
    tablets in half. Every day you randomly pull
    one thing from the bottle - if it's a whole
    tablet, you cut it in half and put the
    leftover half back in the bottle. If it's a
    half-tablet, you take the vitamin. You just
    bought a fresh bottle. How many days, on
    average, will it be before you pull a
    half-tablet out of the bottle?

    Extra credit: What if the halves are less
    likely to come up than the full tablets? They
    are smaller, after all.

[Solution](https://fivethirtyeight.com/features/is-your-friend-full-of-it/)

    RGC: Done

    Monte-Carlo with 100K trials

    Probability of full/half pill is the same

    Seed    Mean
    ----------------
    42      13.21957
    123     13.18686
    2020    13.20745

    About the 13th pill will be a half assuming equal probabilities.

    What if the probability is inversely proportional to the size
    of the pill?  For example, the probability of picking out
    a half pill is half the probability of picking out a full pill.

    Seed    Mean
    ----------------
    42      17.74606
    123     17.7711
    2020    17.73204

    You could go nuts making a plot of mean versus probability.

## 2017-04-14 Bingo Cards

[Problem](https://fivethirtyeight.com/features/how-many-bingo-cards-are-there-in-the-world/)

    Riddler Express

    In standard American bingo, a card is a
    five-by-five grid of squares. The columns are
    labeled B, I, N, G and O, in that order. The
    five squares in the B column can be filled
    with the numbers 1 through 15, those in the I
    column with the numbers 16 through 30, those
    in the N column 31 through 45, and so on. The
    square in the very center of the grid is a
    "free space" on every card.

    How many different possible bingo cards are
    there?

[Solution](https://fivethirtyeight.com/features/pick-a-card-any-card/)

    RGC: Done

    Need to use permutations rather than combinations since the
    order of the numbers is critical in getting the same rows.

    P(n,m) = number of permutations of n things taken m at a time
        P(n,m) = C(n,m) * m!

    B,I,G,O = P(15,5) = 360360
    N has P(15,4) = 32760

    Total is 360360^4 * 32760 = 5.5244e26

    Precisely: 552446474061128648601600000

    Could play ~ 1 billion per second for 17.5 billion years

## 2017-01-20 The Traffic Light Paradox

[Problem](https://fivethirtyeight.com/features/can-you-time-the-stoplight-just-right/)

    From Sebastian de la Torre, an open road
    puzzle:

    You are driving your car on a perfectly flat,
    straight road. You are the only one on the
    road and you can see anything ahead of you
    perfectly. At time t=0, you are at Point A,
    cruising along at a speed of 100 kilometers
    per hour, which is the speed limit for the
    whole road. You want to reach Point C,
    exactly 4 kilometers ahead, in the shortest
    time possible. But, at Point B, 2 kilometers
    ahead of you, there is a traffic light.

    At time t=0, the light is green, but you
    don't know how long it has been green. You do
    know that at the beginning of each second,
    there is a 1 percent chance that the light
    will turn yellow. Once it turns yellow, it
    remains yellow for 5 seconds and then turns
    red for 20 seconds. Your car can accelerate
    or decelerate at a maximum rate of 2 meters
    per second-squared. You must always drive at
    or below the speed limit. You can pass
    through the intersection when the traffic
    light is yellow, but not when it is red.

    What is the best strategy to reach your
    destination as soon as possible?

[Solution](https://fivethirtyeight.com/features/can-you-win-at-tetris-can-you-save-a-species/)

    RGC: TODO

    This is the crazy solution from the website:

    Here’s a summary — from our winner, Ben — of the optimal
    strategy, depending on when you first see the light turn
    yellow:

    For the first 41 seconds of your journey, you’re far enough
    away that you can safely ignore it.

    If it turns yellow between seconds 42 and 47, you’re golden:
    Go full speed straight through the light and you’ll arrive
    in the minimum 0.04 hours, or 144 seconds.

    If it turns yellow between 48 and 58, constantly decelerate
    and then accelerate such that you get back to your top speed
    of 100 kilometers an hour exactly when the light turns green
    again.

    Between 59 and 60, slam on the brakes, and then
    re-accelerate until you hit the green light perfectly.
    (Although, in this case, you won’t be quite able to reach
    your top speed as you pass it.)

    If it’s between 61 and 67, slam on the brakes and then drive
    in reverse for a while! Then use that extra road to speed up
    and arrive at the light just when it turns green. If it
    hasn’t turned yellow by second 65, you’ll want to
    proactively brake just after that time. Safety first!

    At 68 seconds or later, you’ll want to have slowed down,
    then re-accelerate back to 100 kilometers per hour.

    The end result: Your trip takes about 146.35 seconds on
    average, only about 2.35 seconds longer than if the
    stoplight weren’t there at all.


## 2017-01-13 Birthday Candle Blowout

[Problem](https://fivethirtyeight.com/features/how-long-will-it-take-to-blow-out-the-birthday-candles/)

    Riddler Express

    From Conor McMeel, a birthday party puzzle:

    It's your 30th birthday (congrats, by the
    way), and your friends bought you a cake with
    30 candles on it. You make a wish and try to
    blow them out. Every time you blow, you blow
    out a random number of candles between one
    and the number that remain, including one and
    that other number. How many times do you blow
    before all the candles are extinguished, on
    average?

[Solution](https://fivethirtyeight.com/features/can-you-time-the-stoplight-just-right/)

    RGC: Done

    Monte-Carlo, 100K trials, seed=42

    Age     Mean
    ---------------
    1       1.00000
    2       1.49930
    4       2.08264
    10      2.92952
    30      4.00167
    58      4.64589
    60      4.67995
    65      4.75654
    80      4.96559
    100     5.18247

    The curve looks logarithmic.  Probably k1+k2*log-base2(n)

    According to the Riddler it is just a harmonic sum:

    sum(1/i,i,1,age)

    They get there by considering 1, 2, 3, 4 candles and
    noting the pattern in the probabilities.

