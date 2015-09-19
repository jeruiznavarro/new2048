subroutine load_game(auxiliary_empty_cells,auxiliary_empty_cells_history,current_empty_cells_history,empty_cells,empty_cells_history,matrix,matrix_history,score_history,call_from_start)
	implicit none!all variables must be declared
	logical::file_exists=.true.!if true, the temporary file to store the matrix is present
	logical,intent(in)::call_from_start!this variable tells the subroutine if it's being called from the start subroutine or not so that the message for the player can be properly displayed
	character(8)::datechar='--------'!this character variable stores the current date for the names of the output files
	character(1000)::filename!the name of the file to load from
	character(10)::timechar='----------'!this character variable stores the current time for the names of the output files
	integer(4),intent(inout)::auxiliary_empty_cells(0:255)!this vector keeps track of where the index of a certain cell is located in the empty_cells array, for example: empty_cells(0:3)=(/1,3,0,2/) would mean that the values of this array are the following: auxiliary_empty_cells(0:3)=(/2,0,1,3/), thus, only the index of a cell is needed when its interal data are required
	integer(4),intent(inout)::auxiliary_empty_cells_history(0:255,0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4)::cells!number of cells per side of the square to be used in the game
	integer(4)::current_empty_cells!this is the amount of empty cells in a certain moment
	integer(4),intent(inout)::current_empty_cells_history(0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4),intent(inout)::empty_cells(0:255)!the indeces of empty cells are sequentially kept here with no occupied cells in between, all of those are at the end of the array
	integer(4),intent(inout)::empty_cells_history(0:255,0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4)::history_position!this variable keeps track of where should the program write in the history arrays
	integer(4)::i=0!first auxiliary index for the matrix
	integer(4)::j=0!second auxiliary index for the matrix
	integer(4)::k=0!third auxiliary index for the matrix_history array
	integer(4),intent(inout)::matrix(0:15,0:15)!all the number cells are here
	integer(4),intent(inout)::matrix_history(0:15,0:15,0:99)!history of player movements, when stored movements reach 99, it saves the next snapshot of the matrix in 0, overwriting the previous value, and starts overwriting the next ones as more snapshots are generated by the player
	integer(4)::score!this keeps the puntuation of the game
	integer(4)::seed(8)=0!seed for the random number generator
	integer(4),intent(inout)::score_history(0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4)::snapshots!this is the amount of movements stored in the third index of matrix_history, when it reaches 100 it doesn't increase anymore
	common /basic/ cells,current_empty_cells,history_position,snapshots!sharing the variables needed for this subroutine except score
	common /score/ score!sharing the score variable too

	call date_and_time(date=datechar,time=timechar,values=seed)!creating a seed using the clock of the computer
	call srand(1000*seed(8)+3*seed(7)*seed(6)/10)!initializing the random number generator
	if(call_from_start)then
		write(*,*) 'set title "Which file do you want to load? Introduce its name or path."'!asking the player for the name of the file
		write(*,*) "plot '-' lc rgb "//'"#FFFFFF"'!it's necessary to plot something in the graph, so plotting a single white point is the best idea
		write(*,*) '0.5 0.5'!the coordinates of said point
		write(*,*) 'e'!end of input for the point
	else
		write(*,*) 'set title "Which file do you want to load? Introduce its name or path."'!asking the player for the name of the file
		write(*,*) 'replot'!updating the output
	end if
10	read(*,*) filename!reading the input
	inquire(file=filename,exist=file_exists)!checking if the file is there
	if(file_exists)then
		open(20,file=filename,action='read',form='unformatted',access='stream')!opening the file
	else
		write(*,*) 'set title "File not found, try again or try with another file."'!invalid input
		write(*,*) 'replot'!updating the output
		go to 10!cycling through this if loop till a valid input is obtained
	end if
	read(20) cells,current_empty_cells,history_position,score,snapshots!reading the scalar variables
	do j=0,15
		do i=0,15
			read(20) matrix(i,j)!reading the main matrix
		end do
	end do
	do i=0,255
		read(20) auxiliary_empty_cells(i),empty_cells(i)!reading both empty cells arrays
	end do
	do k=0,99
		do j=0,15
			do i=0,15
				read(20) matrix_history(i,j,k)!reading the matrix_history array
			end do
		end do
	end do
	do j=0,99
		do i=0,255
			read(20) auxiliary_empty_cells_history(i,j),empty_cells_history(i,j)!reading both empty cells history arrays
		end do
	end do
	do i=0,99
		read(20) current_empty_cells_history(i),score_history(i)!reading the current empty cells and score history arrays
	end do
	close(20)!closing the file after everything has been read
	call output(cells,matrix)!updating what the player sees in the screen
	return
end subroutine load_game