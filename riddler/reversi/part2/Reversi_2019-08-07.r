
print("Welcome to Ultimate Reversi!")
print("2019-08-08 Version")
print("By Jack Davis, www.stats-et-al.com")
print("")
print("Have your plot window available for clicking...")
print("type play.game() to quick start!")
print("")
print("or type board = import.board(filename); play.game(board) to start a custom game")
print("type dir() to see available boards")

print("Then, click on any of the large grey circles to place a stone.")



### Initialize a board from an imported file
import.board = function(filename, echo=TRUE)
{
	rawboard = readLines(filename)
	rawchars = unlist(strsplit(rawboard,""))
	Ny = length(rawboard)
	Nx = length(rawchars) / Ny
	board = matrix(rawchars,byrow=TRUE,nrow=Ny,ncol=Nx)

	if(echo){print(board)}
	return(board)
}


export.board = function(board, filename)
{
	output = character(0)
	for(k in 1:nrow(board))
	{
		thisline = paste(board[k,],collapse="")	
		output = c(output,thisline)
	}
	
	writeLines(output,filename)

}


### Initialize a board
### While this demo only uses the Othello variant of Reversi and two size variants
### a wide variety of sizes and number of players is possible
setup.board = function(style = "Basic Othello")
{
	board = character(0)

	if(style == "Basic Othello")
	{
		board = matrix(".",nrow=8,ncol=8)
		board[4,4] = "W"
		board[5,5] = "W"
		board[4,5] = "B"
		board[5,4] = "B"
	}
	
	if(style == "3 Player 9x9")
	{
		board = matrix(".",nrow=9,ncol=9)
		board[4,4] = "B"
		board[5,6] = "B"
		board[6,5] = "B"
		board[4,5] = "W"
		board[5,4] = "W"
		board[6,6] = "W"
		board[4,6] = "R"
		board[5,5] = "R"
		board[6,4] = "R"
	}
	
	if(style == "Double Board")
	{
		board = matrix(".",nrow=6,ncol=13)
		board[,7] = "#"
		board[3,3] = "W"
		board[4,4] = "W"
		board[3,4] = "B"
		board[4,3] = "B"
		board[3,10] = "W"
		board[4,11] = "W"
		board[3,11] = "B"
		board[4,10] = "B"
	}
	
	if(style == "Double Start")
	{
		board = matrix(".",nrow=6,ncol=13)
		board[3,3] = "W"
		board[4,4] = "W"
		board[3,4] = "B"
		board[4,3] = "B"
		board[3,10] = "W"
		board[4,11] = "W"
		board[3,11] = "B"
		board[4,10] = "B"
	}
	
	if(style == "Diamond")
	{
		board = matrix(".",nrow=10,ncol=10)
		board[5,5] = "W"
		board[6,6] = "W"
		board[5,6] = "B"
		board[6,5] = "B"
		
		board[1,c(1:4,7:10)] = " "
		board[2,c(1:3,8:10)] = " "
		board[3,c(1:2,9:10)] = " "
		board[4,c(1,10)] = " "
		board[7,c(1,10)] = " "
		board[8,c(1:2,9:10)] = " "
		board[9,c(1:3,8:10)] = " "
		board[10,c(1:4,7:10)] = " "
	}
	
	
	if(style == "4 Player Two Islands")
	{
		board = matrix(".",nrow=10,ncol=10)
		board[5,c(3,4,7,8)] = c("B","W","U","Y")
		board[6,c(3,4,7,8)] = c("W","B","Y","U")
	}
	
	if(style == "Two Islands")
	{
		board = matrix(".",nrow=10,ncol=10)
		board[5,c(3,4,7,8)] = c("B","W","B","W")
		board[6,c(3,4,7,8)] = c("W","B","W","B")
	}
	
	if(style == "Othello Wide")
	{
		board = matrix(".",nrow=4,ncol=10)
		board[2,5] = "W"
		board[3,6] = "W"
		board[2,6] = "B"
		board[3,5] = "B"
	}
	
	if(style == "Othello 10")
	{
		board = matrix(".",nrow=10,ncol=10)
		board[5,5] = "W"
		board[6,6] = "W"
		board[5,6] = "B"
		board[6,5] = "B"
	}
	
	if(style == "Othello 12")
	{
		board = matrix(".",nrow=12,ncol=12)
		board[6,6] = "W"
		board[7,7] = "W"
		board[6,7] = "B"
		board[7,6] = "B"
	}
	
	if(length(board) == 0){
	print("Style must be one of: Basic Othello, 3 Player 9x9, Double Start, Diamond, 4 Player Two Islands, Two Islands, Othello Wide, Othello 10, Othello 12")
	print("Or import a board from a txt with import.board(filename)")
	}
	return(board)

}



### Get the sequence of stones and spaces / walls
### That are 'seen' from a given position on the board
### in a particular direction
### starting from the closest space next to 'position' 
look.to = function(board, position, direction)
{
	### Initialize
	stones = character(0)
	xlist = numeric(0)
	ylist = numeric(0)
	this_x = position[2] ## Note the x-y reversal here
	this_y = position[1] ## This is because in a matrix, the coords are [y,x]

	## Check that the direction is one of the eight allowable
	if(!(direction %in% c("N","NE","E","SE","S","SW","W","NW")))
	{
		print("!!!! ERROR !!!! Not an allowable direction")
		return("!!!! ERROR !!!! Not an allowable direction")
	}

	## Check if the starting position is somewhere on the board
	if(!(this_x > 0 & this_x <= ncol(board) & this_y > 0 & this_y <= nrow(board)))
	{
		print("!!!! ERROR !!!! Position is out of bounds")
		return("!!!! ERROR !!!! Position is out of bounds")
	}

	## Translate the direction into x-y coordinate changes
	if(direction == "N"){  xstep = 0;	ystep = -1}
	if(direction == "NE"){ xstep = 1;	ystep = -1}
	if(direction == "E"){  xstep = 1;	ystep = 0}
	if(direction == "SE"){ xstep = 1;	ystep = 1}
	if(direction == "S"){  xstep = 0;	ystep = 1}
	if(direction == "SW"){ xstep = -1;	ystep = 1}
	if(direction == "W"){  xstep = -1;	ystep = 0}
	if(direction == "NW"){ xstep = -1;	ystep = -1}

	## Do this until we look to the edge of the board
	while(this_x > 0 & this_x <= ncol(board) & this_y > 0 & this_y <= nrow(board))
	{
		### Record the stone (or space) and xy coords at the observed location
		stones = c(stones, board[this_y,this_x])
		xlist = c(xlist, this_x)
		ylist = c(ylist, this_y)

		### Iterate the observed location based on the selected direction
		this_x = this_x + xstep
		this_y = this_y + ystep
	}
	
	### Output the stones/spaces, x coords, or y coords of the observed locations
	#if(output_form == "stones"){output = stones}
	#if(output_form == "xlist"){output = xlist}
	#if(output_form == "ylist"){output = ylist}
	#output = output[-1]
	
	#if(output_form == "stones"){output = paste(output, collapse = "")}

	stones = stones[-1]
	stones = paste(stones, collapse= "")
	xlist = xlist[-1]
	ylist = ylist[-1]
	output = list(stones=stones, xlist=xlist, ylist=ylist)
	return(output)
}


### Calls look.to for all eight directions around a given position
look.around = function(board, position)
{
	### Initialize
	results = rep("",8)
	count = 1

	### For each of the eight directions
	for(this_direction in c("N","NE","E","SE","S","SW","W","NW"))
	{
		### Get the state of each space outward in that direction
		### to the edge of the board
		results[count] = look.to(board, position, this_direction)$stones
		
		count = count + 1
	}
	
	### Return the sequence of spaces in all eight directions as a vector of 8 strings
	return(results)
}

### Evaluates the number of stones that can be captures by a player along a 'look'
### A look is the 'stones' output of look.to
legal.look = function(player, look)
{
	## First, explode the string 
	look = strsplit(look, "")[[1]]

	## There needs to be at least two pieces out for this to be legal
	if(length(look) < 2){ return(0)}

	## There must be at least one enemy piece at the start of the look
	## Enemies cannot extend all the way to the edge of the board
	Nenemies = 0
	enemy_chain = TRUE
	while( Nenemies < length(look) & enemy_chain)
	{
		### Examine a space, if it's anything except 
		### the current player's piece, a space, or a wall, it's an enemy piece
		examined_piece = look[Nenemies + 1]
		if(examined_piece %in% c(player,"."," ","#"))
		{
			enemy_chain = FALSE  ## If it's not an enemy, stop looking
		}
		else
		{
			Nenemies = Nenemies + 1 ## If it is an enemy, iterate and keep looking
		}
	}
	
	### If there are enemy pieces all the way to the end of the board, there can be no sandwich
	### Return 'no capture'.
	if(Nenemies == length(look)){return(0)}

	## There must be an allied piece at immediately after the enemy pieces
	## If there is, return the number of pieces that can be captured along this line.
	examined_piece = look[Nenemies + 1]
	if(examined_piece == player)
	{
		return(Nenemies)
	}

	### Otherwise (and in any bizarre cases that were missed) return 'no capture'
	return(0)
}

### Takes output of eight looks from look.around and passes each of them to legal.look one at a time 
### Returns the set of directions upon which a capture is possible by the given player
### A move is legal if and only if at least one capture can be made on at least one direction.
legal.directions = function(player, around)
{
	### Initialize
	legal_looks = rep(FALSE,8)

	### For each of the eight directions
	### Take the sequence of spaces from this space out the edge of the board
	### and determine if a capture can be made along that direction
	for(k in 1:length(around))
	{
		this_look = around[k]
		legal_looks[k] = legal.look(player, look=this_look)
	}

	### Return the directions in which a capture is made from this space
	### Or return character(0) if there are no captures in any direction
	directions = c("N","NE","E","SE","S","SW","W","NW")
	return(directions[legal_looks > 0])
}



### Scan the board for legal moves
### Return a boolean matrix of the legal moves available to the given player
which.legal = function(board,player)
{
	### Initialize
	Nx = ncol(board)
	Ny = nrow(board)
	legal_board = matrix(FALSE,nrow=Ny, ncol=Nx)

	## For each space on the board
	for(y in 1:Ny)
	{
		for(x in 1:Nx)
		{
			## If that space is available
			if(board[y,x] == ".")
			{
				### Look in all eight directions from here
				around = look.around(board, position=c(y,x))
				Ndirections = legal.directions(player,around)
				
				### If there is a capture in any direction, then there is a legal move here
				### Mark it so
				if(length(Ndirections) >= 1){legal_board[y,x] = TRUE}
			}
		}
	}
	## Return a boolean matrix of the legal moves
	return(legal_board)
}



plot.stones = function(board, legal_board)
{
	## Get the values and dimensions of the board
	chars = c(board)
	legal = c(legal_board)
	Nx = ncol(board)
	Ny = nrow(board)

	## Get the coordinates of each space. 
	## In a matrix, y=1 is the top, while when plotting it's the bottom, so reverse y.
	x = rep(1:Nx,each=Ny)
	y = rep(1:Ny,times=Nx)
	y = rev(y)
	
	draw_col = rep("",length(chars))
	
	draw_col[which(chars == ".")] = "gray"
	draw_col[which(chars == "W")] = "white"
	draw_col[which(chars == "B")] = "black"
	draw_col[which(chars == "G")] = "green"
	draw_col[which(chars == "R")] = "red"
	draw_col[which(chars == "U")] = "blue"
	draw_col[which(chars == "Y")] = "yellow"

    # RGC
    # I found the gray "legal moves" hard to see so I changed them
    # to red.  If you want the original performance just comment
    # out the following line.
    draw_col[legal] = "red"

	draw_rad = rep(0.1,length(chars))
	draw_rad[legal] = 0.2
	draw_rad[!(chars %in% c("."," ","#"))] = 0.35
	#draw_rad[chars %in% c(" ","#")] = 0
	
	for(k in 1:length(chars))
	{
		if(draw_col[k] != "")
		{
			draw.circle(x[k],y[k],radius=draw_rad[k],border="black",col=draw_col[k])
		}
		
		if(chars[k] == "#")
		{
			size = 0.5
			corners_x = c(x[k]-size, x[k]+size, x[k]+size, x[k]-size)
			corners_y = c(y[k]-size, y[k]-size, y[k]+size, y[k]+size)
			polygon(corners_x,corners_y,col="gray")
		}
	}

}


### Take a board state, active player, and possibly the matrix of legal moves,
### and draw this information as a plot.
plot.game = function(board,player,legal_board=NULL,showlegal=TRUE)
{

	## Get the values and dimensions of the board
	chars = c(board)
	Nx = ncol(board)
	Ny = nrow(board)

	## Get the coordinates of each space. 
	## In a matrix, y=1 is the top, while when plotting it's the bottom, so reverse y.
	x = rep(1:Nx,each=Ny)
	y = rep(1:Ny,times=Nx)
	y = rev(y)
	
	## Use the standard alpha-numeric coordinate system, unless the board is too wide.
	yborder = as.character((1:Ny)%%10)
	xborder = letters[1:Nx]
	if(Ny > 26)
	{
		xborder = as.character((1:Nx)%%10)
	}
	
	## Make a new plot, establish the borders
	plot.new()
	plot.window(xlim=c(-0.5,Nx+1.5), ylim=c(-0.5,Ny+2.5))

	## Draw the board
	#points(x,y,pch=chars,cex=3)
	plot.stones(board, legal_board)
	
	## Draw the edges of the board
	points(x=rep(0,Ny),		y=Ny:1,	pch=yborder)
	points(x=rep(Nx+1,Ny),	y=Ny:1,	pch=yborder)
	points(y=rep(0,Nx),		x=1:Nx,	pch=xborder)
	points(y=rep(Ny+1,Nx),	x=1:Nx,	pch=xborder)


	## Mark all the legal moves with red circles
	# if(showlegal)
	# {
	# 	legal_chars = rep("",length(board))
	# 	legal_chars[legal_board] = 8
	# 	points(x,y,pch=legal_chars,cex=2,col="red")
	# 	points(x[legal_board], y[legal_board], pch="*", cex=3, col="red")
	# }
	
	## Print the current player and their score at the top
	score = length(which(board == player))
	text(x=(Nx+1)/2,y=Ny+2,label=paste0("Current Player: ",player, ", score: ",score),cex=2)
}



### Checks if a move at the position is legal by a given this_player on the given board.
### If it is, update the board by placing a stone for this_player at position
### and make all the appropriate captures.
play.move = function(board, this_player, position)
{
	## Check if position is available
	if(board[position[1],position[2]] != ".")
	{
		print("Stone must be placed on an empty place on the board")
		return(board)
	}

	### Look in all eight directions from this position, store these looks as 'around'
	### Find which, if any, of these directions lead to at least one capture
	around = look.around(board, position)
	legal_directions = legal.directions(player = this_player, around)
	
	new_board = board
	
	### For each direction that was legal
	for(this_direction in legal_directions)
	{
		this_look = look.to(board, position, this_direction)
		## Find the coordinates of the stones that are being captured
		x_to_change = this_look$xlist #, output_form="xlist")
		y_to_change = this_look$ylist #, output_form="ylist")

		## Change the captured stones to those of the active player
		stones_to_change = this_look$stones
		Nenemies = legal.look(player = this_player, look=stones_to_change)
			
		for(k in 1:Nenemies)
		{
			new_board[y_to_change[k],x_to_change[k]] = this_player
		}
	}
	
	## Finally, as long as a capture was made, place a stone of the active player's at the given position
	if(length(legal_directions > 0))
	{
		new_board[position[1],position[2]] = this_player
	}
	
	## Return the updated board state
	return(new_board)
}



### The main function that that runs the whole game
play.game = function(board=character(0))
{
	require(plotrix)
	par(bg = "darkgreen")
	par(mar = c(0,0,0,0))
	## If no starting board has been specified, use the default Othello board
	if(length(board) == 0)
	{
		board = setup.board()
	}

	## Find which players are on this board
	player_list = sort(setdiff(unique(c(board)),c(".","#"," ")))

    # RGC - this was a bit obnoxious
    ## Turn off the sound on each mouseclick
    options(locatorBell=FALSE)
	
	## Initialize all the variables
	Nplayers = length(player_list)
	current_player = player_list[1]
	players_skipped = 0
	Nx = ncol(board)
	Ny = nrow(board)
	new_board = board
	
	## Establish legal moves on the starting board
	legal_board = which.legal(board, current_player)
	plot.game(board,current_player,legal_board)

	## While the board is playable, keep seeking and processing moves
	while(  any(board == ".") & players_skipped < length(player_list) & any(names(dev.cur()) != "null device"))
	{
	
		### If there are no legal moves, don't register the move
		### Mark that the player has been skipped
		if(all(legal_board == FALSE)){players_skipped = players_skipped + 1}
		else{players_skipped = 0}
		
		## While there is any legal move for this player, and such a move has yet to be selected
		while(all(board == new_board) & any(legal_board == TRUE) & any(names(dev.cur()) != "null device"))
		{
		
			## Take in a mouse click	
			mouseclick = locator(1)
			input_x = round(mouseclick$x)
			input_y = round(mouseclick$y)
			input_y = nrow(board) - input_y + 1
			


			### If the mouse click was in the bounds of the board
			if(input_x > 0 & input_x <= Nx & input_y > 0 & input_y <= Ny)
			{
				### ..and if it was on a legal move
				if(legal_board[input_y,input_x])
				{
					### ...register the click as a move (and allow the game to progress)
					new_board = play.move(board,this_player=current_player,position=c(input_y,input_x))
				}
			}
		}
		
		## Update the active player
		player_idx = which(player_list == current_player)
		current_player = player_list[ 1 + (player_idx %% Nplayers)]

		## Update the board state
		board = new_board
		legal_board = which.legal(board, current_player)

		## Plot the game based on the new board state
		plot.game(board,current_player,legal_board)
	} # end of game
	
	## print the score and return the ending board state
	print(table(board))
	par(bg = "white")
	par(mar = c(5.1,4.1,4.1,2.1))
	return(board)

}



#play.game()


#setwd("C:\\Users\\User\\Desktop\\Projects 2019\\Ultimate Reversi in R")
#board = import.board("Board_2P_StartCorners.txt")
#play.game(board)

 
 
