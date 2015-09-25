subroutine help(call_from_start)
	implicit none!all variables must be declared
	logical,intent(in)::call_from_start!this variable tells the subroutine if it's being called from the start subroutine or not so that the message for the player can be properly displayed
	character(1)::input_character='-'!this will be used to pass orders to the program

	if(call_from_start)then
		write(*,*) 'set title "What would you like to know about? For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!instructions for the player
		write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
		write(*,*) '0.5 0.5'!the coordinates of said point
		write(*,*) 'e'!end of input for the point
10		read(*,*) input_character!reading player command
		if(input_character=='s')then
			write(*,*) 'set title "The key to the game is to keep the cell with the highest value in a\ncorner where the row/column it belongs to is full of cells.\nThis way, if moving in the direction perpendicular to the\nrow/column is restricted to bringing cells closer to the corner cell it will be easier\nto keep the cells with big values organized and maximize the amount of empty cells so there is\nmore space available for maneuvering and having higher cells. Press any key to continue."'!instructions for the player
			write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
			write(*,*) '0.5 0.5'!the coordinates of said point
			write(*,*) 'e'!end of input for the point
			read(*,*) !letting the player read the previous message
			write(*,*) 'set title "What would you like to know about? For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!instructions for the player
			write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
			write(*,*) '0.5 0.5'!the coordinates of said point
			write(*,*) 'e'!end of input for the point
			go to 10!going back to the beignning
		else if(input_character=='m')then
			write(*,*) 'set title "The game is simple, you have to move the tiles to make the ones with the same value collide.\nWhen this happens their values are added and your score increases by that sum.\nAfter each movement a new tile will be occupied by a non-null number,\nif all the tiles are full and you can not score any points you lose.\nWhen you move the tiles they all move in the same direction if there are no obstacles\nin their path (the walls or tiles with different values). Press any key to continue."'!instructions for the player
			write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
			write(*,*) '0.5 0.5'!the coordinates of said point
			write(*,*) 'e'!end of input for the point
			read(*,*) !letting the player read the previous message
			write(*,*) 'set title "What would you like to know about? For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!instructions for the player
			write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
			write(*,*) '0.5 0.5'!the coordinates of said point
			write(*,*) 'e'!end of input for the point
			go to 10!going back to the beignning
		else if(input_character=='l')then
			write(*,*) 'set title "wasd alternates between using those keys as arrows and using the arrows of the numpad (8624).\nq quits the game, n starts a new one, s saves it to a binary file and l loads it from a binary file.\nb enters the history mode where you can navigate the movements (within a certain range).\nAnd finally h opens this mode and lets you read these topics. Press any key to continue."'!instructions for the player
			write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
			write(*,*) '0.5 0.5'!the coordinates of said point
			write(*,*) 'e'!end of input for the point
			read(*,*) !letting the player read the previous message
			write(*,*) 'set title "What would you like to know about? For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!instructions for the player
			write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
			write(*,*) '0.5 0.5'!the coordinates of said point
			write(*,*) 'e'!end of input for the point
			go to 10!going back to the beignning
		else if(input_character=='b')then
			write(*,*) 'set title "The movements you make while playing are saved to the history of your game.\nThere is a maximum of 100 movements, you will not be able to go back further than that,\nnor will you be able to go beyond the last movement you were in when you\nentered the history mode. You can move backwards or forwards within these range using\npositive or negative numbers respectively, the absolute value of the number will\ntell the game how far it should move along the history. Press any key to continue."'!instructions for the player
			write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
			write(*,*) '0.5 0.5'!the coordinates of said point
			write(*,*) 'e'!end of input for the point
			read(*,*) !letting the player read the previous message
			write(*,*) 'set title "What would you like to know about? For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!instructions for the player
			write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
			write(*,*) '0.5 0.5'!the coordinates of said point
			write(*,*) 'e'!end of input for the point
			go to 10!going back to the beignning
		else if(input_character=='e')then
			return!going back to the main program
		else
			write(*,*) 'set title "Wrong input, try again. For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!wrong input
			write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
			write(*,*) '0.5 0.5'!the coordinates of said point
			write(*,*) 'e'!end of input for the point
			go to 10!cycling through this if loop till a valid input is obtained
		end if
	else
		write(*,*) 'set title "What would you like to know about? For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!instructions for the player
		write(*,*) 'replot'!updating the output
20		read(*,*) input_character!reading player command
		if(input_character=='s')then
			write(*,*) 'set title "The key to the game is to keep the cell with the highest value in a\ncorner where the row/column it belongs to is full of cells.\nThis way, if moving in the direction perpendicular to the\nrow/column is restricted to bringing cells closer to the corner cell it will be easier\nto keep the cells with big values organized and maximize the amount of empty cells so there is\nmore space available for maneuvering and having higher cells. Press any key to continue."'!instructions for the player
			write(*,*) 'replot'!updating the output
			read(*,*) !letting the player read the previous message
			write(*,*) 'set title "What would you like to know about? For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!instructions for the player
			write(*,*) 'replot'!updating the output
			go to 20!going back to the beignning
		else if(input_character=='m')then
			write(*,*) 'set title "The game is simple, you have to move the tiles to make the ones with the same value collide.\nWhen this happens their values are added and your score increases by that sum.\nAfter each movement a new tile will be occupied by a non-null number,\nif all the tiles are full and you can not score any points you lose.\nWhen you move the tiles they all move in the same direction if there are no obstacles\nin their path (the walls or tiles with different values). Press any key to continue."'!instructions for the player
			write(*,*) 'replot'!updating the output
			read(*,*) !letting the player read the previous message
			write(*,*) 'set title "What would you like to know about? For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!instructions for the player
			write(*,*) 'replot'!updating the output
			go to 20!going back to the beignning
		else if(input_character=='l')then
			write(*,*) 'set title "wasd alternates between using those keys as arrows and using the arrows of the numpad (8624).\nq quits the game, n starts a new one, s saves it to a binary file and l loads it from a binary file.\nb enters the history mode where you can navigate the movements (within a certain range).\nAnd finally h opens this mode and lets you read these topics. Press any key to continue."'!instructions for the player
			write(*,*) 'replot'!updating the output
			read(*,*) !letting the player read the previous message
			write(*,*) 'set title "What would you like to know about? For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!instructions for the player
			write(*,*) 'replot'!updating the output
			go to 20!going back to the beignning
		else if(input_character=='b')then
			write(*,*) 'set title "The movements you make while playing are saved to the history of your game.\nThere is a maximum of 100 movements, you will not be able to go back further than that,\nnor will you be able to go beyond the last movement you were in when you\nentered the history mode. You can move backwards or forwards within these range using\npositive or negative numbers respectively, the absolute value of the number will\ntell the game how far it should move along the history. Press any key to continue."'!instructions for the player
			write(*,*) 'replot'!updating the output
			read(*,*) !letting the player read the previous message
			write(*,*) 'set title "What would you like to know about? For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!instructions for the player
			write(*,*) 'replot'!updating the output
			go to 20!going back to the beignning
		else if(input_character=='e')then
			return!going back to the main program
		else
			write(*,*) 'set title "Wrong input, try again. For strategy tips introduce s.\nFor an explanation of the mechanics introduce m. For a list of gameplay commands introduce l.\nFor more on the history mode introduce b. To go back to the game introduce e."'!wrong input
			write(*,*) 'replot'!updating the output
			go to 20!cycling through this if loop till a valid input is obtained
		end if
	end if
end subroutine help