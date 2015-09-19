subroutine new_game(auxiliary_empty_cells,auxiliary_empty_cells_history,current_empty_cells_history,empty_cells,empty_cells_history,matrix,matrix_history)
	implicit none!all variables must be declared
	character(8)::datechar='--------'!this character variable stores the current date for the names of the output files
	character(10)::timechar='----------'!this character variable stores the current time for the names of the output files
	integer(4),intent(inout)::auxiliary_empty_cells(0:255)!this vector keeps track of where the index of a certain cell is located in the empty_cells array, for example: empty_cells(0:3)=(/1,3,0,2/) would mean that the values of this array are the following: auxiliary_empty_cells(0:3)=(/2,0,1,3/), thus, only the index of a cell is needed when its interal data are required
	integer(4),intent(inout)::auxiliary_empty_cells_history(0:255,0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4)::cells!number of cells per side of the square to be used in the game
	integer(4)::coordinates_to_index!function to convert cell coordinates into the index of a cell
	integer(4)::current_empty_cells!this is the amount of empty cells in a certain moment
	integer(4),intent(inout)::current_empty_cells_history(0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4),intent(inout)::empty_cells(0:255)!the indeces of empty cells are sequentially kept here with no occupied cells in between, all of those are at the end of the array
	integer(4),intent(inout)::empty_cells_history(0:255,0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4)::history_position!this variable keeps track of where should the program write in the history arrays
	integer(4)::i=0!first auxiliary index for the matrix
	integer(4)::indeces(4)=0!random indeces for the numbers are stored in this vector
	integer(4)::j=0!second auxiliary index for the matrix
	integer(4)::k=0!auxiliary index
	integer(4),intent(inout)::matrix(0:15,0:15)!all the number cells are here
	integer(4),intent(inout)::matrix_history(0:15,0:15,0:99)!history of player movements
	integer(4)::score!this keeps the puntuation of the game
	integer(4)::seed(8)=0!seed for the random number generator
	integer(4)::snapshots!this is the amount of movements stored in the third index of matrix_history, when it reaches 100 it doesn't increase anymore
	integer(4)::tag=0!temporary variable for the index of cells
	common /basic/ cells,current_empty_cells,history_position,snapshots!sharing the variables needed for this subroutine
	common /score/ score!sharing the score variable too

	write(*,*) 'set title "How many cells per side would you like? Introduce an integer number between 3 and 16."'!asking the player how big should be the playing square
	write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
	write(*,*) '0.5 0.5'!the coordinates of point to replot like in the start subroutine
	write(*,*) 'e'!end of input for the point
10	read(*,*) cells!reading the size
	if((cells>16).or.(cells<3))then
		write(*,*) 'set title "Wrong number, the size must be between 3 and 16, try again."'!invalid input
		write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
		write(*,*) '0.5 0.5'!the coordinates of point to replot like in the start subroutine
		write(*,*) 'e'!end of input for the point
		go to 10!cycling through this if loop till a valid input is obtained
	end if
	current_empty_cells=cells**2!updating the amount of empty cells
	do k=0,current_empty_cells-1
		empty_cells(k)=k!setting all the cells as empty
		empty_cells_history(k,history_position)=k!and keeping the values for the history too
		auxiliary_empty_cells(k)=k!and storing in which position of the previous vector they are located
		auxiliary_empty_cells_history(k,history_position)=k!same for the history of the previous auxiliary array
	end do
	call date_and_time(date=datechar,time=timechar,values=seed)!creating a seed using the clock of the computer
	call srand(1000*seed(8)+3*seed(7)*seed(6)/10)!initializing the random number generator
20	indeces(1)=nint(rand()*dble(cells-1),4)!first index of the first cell
	indeces(2)=nint(rand()*dble(cells-1),4)!second index of the first cell
	indeces(3)=nint(rand()*dble(cells-1),4)!first index of the second cell
	indeces(4)=nint(rand()*dble(cells-1),4)!second index of the second cell
	if((indeces(1)==indeces(3)).and.(indeces(2)==indeces(4)))go to 20!avoiding overwriting between the cells
	do j=0,cells-1
		do i=0,cells-1
			if((i==indeces(1)).and.(j==indeces(2)))then
				tag=coordinates_to_index(i,j,cells)!storing the index to avoid calling the function more than once
				matrix(i,j)=2!generating the first random initial value in a random position
				matrix_history(i,j,history_position)=2!and storing it in the history matrix
				empty_cells(tag)=empty_cells(current_empty_cells-1)!replacing the space occupied by this cell in the cell list by the last one on it
				empty_cells_history(tag,history_position)=empty_cells(tag)!and keeping the value for the history too
				auxiliary_empty_cells(current_empty_cells-1)=tag!the position of the last cell in the previous array has moved and the movement is recorded here
				auxiliary_empty_cells_history(current_empty_cells-1,history_position)=tag!and the history is updated with that movement too
				empty_cells(current_empty_cells-1)=-1!this information is redundant now, so it's erased
				empty_cells_history(current_empty_cells-1,history_position)=-1!it's redundant in the history too
				auxiliary_empty_cells(tag)=-1!marking this cell as empty in the auxiliary list
				auxiliary_empty_cells_history(tag,history_position)=-1!doing the same for the history
				current_empty_cells=current_empty_cells-1!updating the amount of empty cells
			else if((i==indeces(3)).and.(j==indeces(4)))then
				if(rand()>0.9)then
					tag=coordinates_to_index(i,j,cells)!storing the index to avoid calling the function more than once
					matrix(i,j)=4!generating the second random initial value in a random position with a higher value, only in 1/10 of the cases
					matrix_history(i,j,history_position)=4!and storing it in the history matrix
					empty_cells(tag)=empty_cells(current_empty_cells-1)!replacing the space occupied by this cell in the cell list by the last one on it
					empty_cells_history(tag,history_position)=empty_cells(tag)!and keeping the value for the history too
					auxiliary_empty_cells(current_empty_cells-1)=tag!the position of the last cell in the previous array has moved and the movement is recorded here
					auxiliary_empty_cells_history(current_empty_cells-1,history_position)=tag!and the history is updated with that movement too
					empty_cells(current_empty_cells-1)=-1!this information is redundant now, so it's erased
					empty_cells_history(current_empty_cells-1,history_position)=-1!it's redundant in the history too
					auxiliary_empty_cells(tag)=-1!marking this cell as empty in the auxiliary list
					auxiliary_empty_cells_history(tag,history_position)=-1!doing the same for the history
					current_empty_cells=current_empty_cells-1!updating the amount of empty cells
				else
					tag=coordinates_to_index(i,j,cells)!storing the index to avoid calling the function more than once
					matrix(i,j)=2!same as before but with the same value as the first one
					matrix_history(i,j,history_position)=2!and storing it in the history matrix
					empty_cells(tag)=empty_cells(current_empty_cells-1)!replacing the space occupied by this cell in the cell list by the last one on it
					empty_cells_history(tag,history_position)=empty_cells(tag)!and keeping the value for the history too
					auxiliary_empty_cells(current_empty_cells-1)=tag!the position of the last cell in the previous array has moved and the movement is recorded here
					auxiliary_empty_cells_history(current_empty_cells-1,history_position)=tag!and the history is updated with that movement too
					empty_cells(current_empty_cells-1)=-1!this information is redundant now, so it's erased
					empty_cells_history(current_empty_cells-1,history_position)=-1!it's redundant in the history too
					auxiliary_empty_cells(tag)=-1!marking this cell as empty in the auxiliary list
					auxiliary_empty_cells_history(tag,history_position)=-1!doing the same for the history
					current_empty_cells=current_empty_cells-1!updating the amount of empty cells
				end if
			else
				matrix(i,j)=0!these cells are empty
				matrix_history(i,j,history_position)=0!saving them in the history matrix too
			end if
		end do
	end do
	call output(cells,matrix)!updating what the player sees in the screen
	current_empty_cells_history(history_position)=current_empty_cells!saving the amount of empty cells to the history as well
	score=0!resetting the score back to zero
	history_position=history_position+1!moving on to the next position in the history of movements
	snapshots=snapshots+1!first snapshot
	return
end subroutine new_game