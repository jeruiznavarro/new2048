subroutine end_game(auxiliary_empty_cells,auxiliary_empty_cells_history,current_empty_cells_history,empty_cells,empty_cells_history,game_over,matrix,matrix_history,score_history)
	implicit none!all variables must be declared
	logical,intent(inout)::game_over!this variable will be false until there are no more possible moves
	character(1)::input_character='-'!this will be used to pass orders to the program
	integer(4),intent(inout)::auxiliary_empty_cells(0:255)!this vector keeps track of where the index of a certain cell is located in the empty_cells array, for example: empty_cells(0:3)=(/1,3,0,2/) would mean that the values of this array are the following: auxiliary_empty_cells(0:3)=(/2,0,1,3/), thus, only the index of a cell is needed when its interal data are required
	integer(4),intent(inout)::auxiliary_empty_cells_history(0:255,0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4),intent(inout)::current_empty_cells_history(0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4),intent(inout)::empty_cells(0:255)!the indeces of empty cells are sequentially kept here with no occupied cells in between, all of those are at the end of the array
	integer(4),intent(inout)::empty_cells_history(0:255,0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4),intent(inout)::matrix(0:15,0:15)!all the number cells are here
	integer(4),intent(inout)::matrix_history(0:15,0:15,0:99)!history of player movements, when stored movements reach 99, it saves the next snapshot of the matrix in 0, overwriting the previous value, and starts overwriting the next ones as more snapshots are generated by the player
	integer(4),intent(inout)::score_history(0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements

	write(*,*) 'set title "GAME OVER!\nTo start a new game introduce n, to load an old game introduce l, to quit the game introduce q."'!asking the player how big should be the playing square
	write(*,*) 'replot'!updating the output
10	read(*,*) input_character!reading the size
	if(input_character=='l')then
		game_over=.false.!if this stays as true, the program will fall in a loop within this subroutine
		call load_game(auxiliary_empty_cells,auxiliary_empty_cells_history,current_empty_cells_history,empty_cells,empty_cells_history,matrix,matrix_history,score_history,.false.)!loading an old game
	else if(input_character=='n')then
		game_over=.false.!if this stays as true, the program will fall in a loop within this subroutine
		call new_game(auxiliary_empty_cells,auxiliary_empty_cells_history,current_empty_cells_history,empty_cells,empty_cells_history,matrix,matrix_history,score_history)!starting a new game
	else if(input_character=='q')then
		write(*,*) 'set title "Press any key to exit. Bye and see you soon!"'!saying goodbye
		write(*,*) 'replot'!updating the output
		read(*,*) !exiting
		stop!terminating the program
	else if(input_character=='h')then
		call help(.false.)!getting help
		write(*,*) 'set title "GAME OVER!\nTo start a new game introduce n, to load an old game introduce l, to quit the game introduce q."'!asking the player how big should be the playing square
		write(*,*) 'replot'!updating the output
		go to 10!going back to read another command
	else
		write(*,*) 'set title "Wrong character (for a new game introduce n, to load a game introduce l, to quit introduce q)"'!invalid input
		write(*,*) 'replot'!updating the output
		go to 10!cycling through this if loop till a valid input is obtained
	end if
	return
end subroutine end_game