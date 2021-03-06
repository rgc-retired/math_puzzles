## Problem

Position 8 queens on a chessboard such that that number of
squares that is not attacked is a maximum

Seems simple enough but the number of combinations is large
C(64,8)~4.4 Billion.  With reflections, translations, rotations,
etc. I am sure the number is much smaller ... but there doesn't
seem to be an obvious alorithm to search out just the unique
configurations.

* queens3.py performs exhaustive search

* queens.tcl provides a board to try the problem manually.


## After exhaustive search

The best achievable score is 11.
There are 48 configurations that achieve this.
Many are reflections or rotations.
They have not been removed.

Assume the squares are numbered 0-63 row-wise starting at the
upper left corner of the board.  The 8 queens should be positioned
as follows to achieve this score:

     0  1  2  9 10 11 40 41 
     0  1  2  9 10 32 40 41 
     0  2  9 11 32 33 40 41 
     0  4  5  8  9 13 16 17 
     0  4  5  9 12 13 16 25 
     0  5  8  9 13 16 17 25 
     1  2 10 11 32 33 40 41 
     1  3 16 19 24 25 32 33 
     1  6  8 10 14 17 48 49 
     1  6  9 13 15 22 54 55 
     2  3  4  8 11 12 24 26 
     2  3  4 16 20 24 32 34 
     2  3  7 10 11 14 23 30 
     2  3  7 10 14 15 22 23 
     2  3 10 11 15 22 23 30 
     2  7 10 14 15 22 23 30 
     3  4  5 11 12 15 29 31 
     3  4  5 19 23 31 37 39 
     4  5  8 12 13 16 17 25 
     4  6 20 23 30 31 38 39 
     5  6  7 12 13 14 46 47 
     5  6  7 13 14 39 46 47 
     5  6 12 13 38 39 46 47 
     5  7 12 14 38 39 46 47 
     8  9 41 48 50 54 57 62 
    14 15 46 49 53 55 57 62 
    16 17 24 25 49 51 56 58 
    16 17 24 25 50 51 57 58 
    16 17 24 49 50 56 57 58 
    16 17 49 50 51 56 57 58 
    22 23 30 31 52 53 61 62 
    22 23 30 31 52 54 61 63 
    22 23 31 53 54 61 62 63 
    22 23 52 53 54 61 62 63 
    24 25 32 33 40 43 57 59 
    24 26 32 40 44 58 59 60 
    29 31 39 43 47 59 60 61 
    30 31 38 39 44 47 60 62 
    32 34 48 51 52 58 59 60 
    33 40 41 48 49 53 56 61 
    33 40 41 48 52 53 60 61 
    33 40 49 52 53 56 60 61 
    37 39 51 52 55 59 60 61 
    38 46 47 50 51 55 58 59 
    38 46 47 50 54 55 58 63 
    38 47 50 51 54 58 59 63 
    40 41 48 49 53 56 60 61 
    46 47 50 54 55 58 59 63 

