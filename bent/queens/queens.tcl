### -----------------------------------------------
# Simulation of Chess: Multiple Queen Coverage
# R. G. Cronce   5-Oct-2008
#
# Inspired by a Bent Brain Tickler, 2008.
# This is a helper application to view the coverage
# of the squares attacked by n queens placed on a
# chess board.
#
# The array of buttons is configured to highlight the
# squares attacked by a queen at the cursor.  Use the
# mouse to drop/pickup a Queen at the current square.
# Squares under attack by placed queens are shaded
# one color.  Squares under attack by a the cursore
# are shaded another color.  Squares that are not under
# attack are a third color.  I keep messing with the
# colors so I can't say for sure what the colors are
# right now.
#
# The total number of squares that are not under attack
# is shown in the lower left corner (called Score).  The
# total number of placed Queens is shown in the lower
# right corner (called Queens).
#
# The original question called for finding the optimal
# placedment of 8 queens to maximize the number of squares
# that were not under attack.  A brute force approach
# requires a very large number of evaluations (approx.
# 4 billion combinations).  Even with pruning, this is a
# daunting search.
#
# BTW: the best I can find is 10 squares not under attack.
#
# Other questions come to mind:
#
# 1 - Minimum number of queens required to attack all squares?
#		(my best is 5)
# 2 - ...
#
### -----------------------------------------------

# Start with a clean slate
foreach i [winfo children .] {destroy $i}

#
# Highlight squares under attack by a queen or the cursor.  If a square
# is already under attack by a placed queen then leave the color alone.
#
proc adjust_color {bid new_color} {
	global g

	set old_color [$bid cget -bg]
	if { ($new_color eq $g(SELECT_COLOR)) && ($old_color eq $g(EMPTY_COLOR)) } {
		$bid configure -bg $g(SELECT_COLOR)
	} elseif { $new_color eq $g(QUEEN_COLOR) } {
		$bid configure -bg $new_color
	}
}

#
# Apply highlight color to square at row i column j
#
proc highlight {i j bg_color} {
	global g

	# Highlight north-south, east-west
	for {set ii 0} {$ii<8} {incr ii} { adjust_color $g($ii,$j) $bg_color }
	for {set jj 0} {$jj<8} {incr jj} { adjust_color $g($i,$jj) $bg_color }
	# Highlight NW
	set ii [expr {$i-1}]; set jj [expr {$j-1}]
	while {($ii>=0) && ($jj>=0)} { adjust_color $g($ii,$jj) $bg_color; incr ii -1; incr jj -1 }
	# Highlight NE
	set ii [expr {$i-1}]; set jj [expr {$j+1}]
	while {($ii>=0) && ($jj<8)}  { adjust_color $g($ii,$jj) $bg_color; incr ii -1; incr jj  1 }
	# Highlight SW
	set ii [expr {$i+1}]; set jj [expr {$j-1}]
	while {($ii<8) && ($jj>=0)}  { adjust_color $g($ii,$jj) $bg_color; incr ii  1; incr jj -1 }
	# Highlight SE
	set ii [expr {$i+1}]; set jj [expr {$j+1}]
	while {($ii<8) && ($jj<8)}   { adjust_color $g($ii,$jj) $bg_color; incr ii  1; incr jj  1 }

	calc_num_left
}

#
# Calculate the number of squares not under attack and the number of placed queens
#
proc calc_num_left {} {
	global g
	global num_left
	global num_queens

	set t 0
	set t2 0
	for {set ii 0} {$ii<8} {incr ii} {
		for {set jj 0} {$jj<8} {incr jj} {
			if {[$g($ii,$jj) cget -bg] eq $g(EMPTY_COLOR)} { incr t }
			if {[$g($ii,$jj) cget -text] eq "Q"}           { incr t2 }
		}
	}
	set num_left $t
	set num_queens $t2
}

#
# Highlight the entire board and update the score
#
proc update_board {} {
	global g
	for {set ii 0} {$ii<8} {incr ii} {
		for {set jj 0} {$jj<8} {incr jj} {
			if {[$g($ii,$jj) cget -text] eq "Q"} { highlight $ii $jj $g(QUEEN_COLOR)}
		}
	}
	calc_num_left
}

proc clear_board {} {
	global g
	for {set ii 0} {$ii<8} {incr ii} {
		for {set jj 0} {$jj<8} {incr jj} {
			$g($ii,$jj) configure -text {}
		}
	}
	lowlight
}

proc toggle_queen {i j} {
	global g
	if {[$g($i,$j) cget -text] eq "Q"} {
		$g($i,$j) configure -text {}
		lowlight
	} else {
		$g($i,$j) configure -text "Q"
	}
	update_board
}

#
# Clear the entire board
#
proc lowlight {} {
	global g
	for {set ii 0} {$ii<8} {incr ii} {
		for {set jj 0} {$jj<8} {incr jj} {
			$g($ii,$jj) configure -bg $g(EMPTY_COLOR)
		}
	}
	update_board
}

###
### Main program
###
global g
global num_left
global num_queens

set num_left 0
set num_queens 0
set g(QUEEN_COLOR) lightgray
set g(SELECT_COLOR) orange
set g(EMPTY_COLOR)  yellow

for {set i 0} {$i<8} {incr i} {
	grid columnconfigure . $i -weight 1 -uniform a
	grid rowconfigure    . $i -weight 1 -uniform b
	for {set j 0} {$j<8} {incr j} {
		set g($i,$j) [button .b$i$j -text {}]
		grid configure $g($i,$j) -row $i -column $j -sticky news
		bind $g($i,$j) <Enter> [list highlight     $i $j $g(SELECT_COLOR)]
		bind $g($i,$j) <Leave> lowlight
		bind $g($i,$j)   <1>   [list toggle_queen  $i $j]
	}
}

label .score1 -text "Score:"
grid configure .score1 -row 8 -column 0 -sticky news
label .score -textvariable num_left
grid configure .score -row 8 -column 1 -sticky news

label .queens1 -text "Queens:"
grid configure .queens1 -row 8 -column 6 -sticky news
label .queens -textvariable num_queens
grid configure .queens -row 8 -column 7 -sticky news

button .clear -text "Clear" -command clear_board
grid configure .clear -row 8 -column 2 -sticky news -columnspan 4

lowlight
update_board
