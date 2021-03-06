subroutine start(auxiliary_empty_cells,auxiliary_empty_cells_history,current_empty_cells_history,empty_cells,empty_cells_history,matrix,matrix_history,score_history)
	implicit none!all variables must be declared
	character(1)::input_character='-'!this will be used to pass orders to the program
	integer(4),intent(inout)::auxiliary_empty_cells(0:255)!this vector keeps track of where the index of a certain cell is located in the empty_cells array, for example: empty_cells(0:3)=(/1,3,0,2/) would mean that the values of this array are the following: auxiliary_empty_cells(0:3)=(/2,0,1,3/), thus, only the index of a cell is needed when its interal data are required
	integer(4),intent(inout)::auxiliary_empty_cells_history(0:255,0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4),intent(inout)::current_empty_cells_history(0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4),intent(inout)::empty_cells(0:255)!the indeces of empty cells are sequentially kept here with no occupied cells in between, all of those are at the end of the array
	integer(4),intent(inout)::empty_cells_history(0:255,0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4),intent(inout)::matrix(0:15,0:15)!all the number cells are here
	integer(4),intent(inout)::matrix_history(0:15,0:15,0:99)!history of player movements, when stored movements reach 99, it saves the next snapshot of the matrix in 0, overwriting the previous value, and starts overwriting the next ones as more snapshots are generated by the player
	integer(4),intent(inout)::score_history(0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements

	write(*,*) 'set title "Welcome to 262144 (yet another version of 2048)!\nTo start a new game introduce n, to load an old game introduce l.\nIntroduce h to get help, you can do this at any time.\nDo not forget to always press enter after you type something."'!instructions for the player
	write(*,*) 'unset key'!the key only gets in the way for the moment
	write(*,*) 'unset xtics'!the tics in the axis are just in the way
	write(*,*) 'unset ytics'!same for the y axis
	write(*,*) 'set format x ""'!the numbers on the x axis are not really useful and take up space for no good reason
	write(*,*) 'set format y ""'!same for the y axis
	write(*,*) 'set xrange [0:1]'!setting the limits of the visualization in the x axis
	write(*,*) 'set yrange [0:1]'!setting the limits of the visualization in the y axis
	write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
	write(*,*) '0.5 0.5'!the coordinates of said point
	write(*,*) 'e'!end of input for the point
10	read(*,*) input_character!reading player command
	if(input_character=='l')then
		call load_game(auxiliary_empty_cells,auxiliary_empty_cells_history,current_empty_cells_history,empty_cells,empty_cells_history,matrix,matrix_history,score_history,.true.)!loading an old game
	else if(input_character=='n')then
		call new_game(auxiliary_empty_cells,auxiliary_empty_cells_history,current_empty_cells_history,empty_cells,empty_cells_history,matrix,matrix_history)!starting a new game
	else if(input_character=='h')then
		call help(.true.)!getting help
		write(*,*) 'set title "To start a new game introduce n, to load an old game introduce l\nand h to get help (you can introduce h to get help at any time).\nDo not forget to always press enter after you type something in the terminal."'!asking again for a new game or to load an old one
		write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
		write(*,*) '0.5 0.5'!the coordinates of said point
		write(*,*) 'e'!end of input for the point
		go to 10!waiting for another input
	else
		write(*,*) 'set title "Wrong character, to start a new game introduce n, to load an old game introduce l."'!invalid input
		write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
		write(*,*) '0.5 0.5'!the coordinates of said point
		write(*,*) 'e'!end of input for the point
		go to 10!cycling through this if loop till a valid input is obtained
	end if
	return
end subroutine start