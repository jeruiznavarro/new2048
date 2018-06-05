subroutine move_down(auxiliary_empty_cells,auxiliary_empty_cells_history,current_empty_cells_history,empty_cells,empty_cells_history,matrix,matrix_history,score_history)
	implicit none!all variables must be declared
	logical::empty=.false.!if true, it means that there's an empty cell in a certain row or column
	logical::exit_1=.false.!if true (and exit_2 true as well), the recursive search for empty cells will end
	logical::exit_2=.false.!if true (and exit_1 true as well), the recursive search for empty cells will end
	logical::game_over!this variable will be false until there are no more possible moves
	logical::no_cells_moved=.true.!if true, it will mean that no cells have moved at all before the subroutine adds another cell
	logical::no_moves!if true, it will mean that there are no possible movements left
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
	integer(4)::index_to_first_coordinate!function to obtain the first coordinate of a cell from its index
	integer(4)::index_to_second_coordinate!function to obtain the second coordinate of a cell from its index
	integer(4)::j=0!second auxiliary index for the matrix
	integer(4)::k=0!first auxiliary counter
	integer(4)::l=0!second auxiliary counter
	integer(4),intent(inout)::matrix(0:15,0:15)!all the number cells are here
	integer(4),intent(inout)::matrix_history(0:15,0:15,0:99)!history of player movements, when stored movements reach 99, it saves the next snapshot of the matrix in 0, overwriting the previous value, and starts overwriting the next ones as more snapshots are generated by the player
	integer(4)::new_cell_first_coordinate=0!the x coordinate of the new cell will be here
	integer(4)::new_cell_index=0!the index of a new cell will be selected at random after every movement and will be stored here
	integer(4)::new_cell_second_coordinate=0!the y coordinate of the new cell will be here
	integer(4)::new_value=0!this will be the value of the cells generated after each movement
	integer(4)::random_component=0!this is used to select a new cell to be occupied out of all the components in empty_cells that are smaller or equal to current_empty_cells-1
	integer(4)::score!this keeps the puntuation of the game
	integer(4),intent(inout)::score_history(0:99)!same as matrix_history, but the player doesn't interact with this variable, it's only kept so it's faster to move back in the history of movements
	integer(4)::snapshots!this is the amount of movements stored in the third index of matrix_history, when it reaches 100 it doesn't increase anymore
	integer(4)::tag=0!temporary variable for the index of cells
	integer(4)::tag_extra=0!same as above
	common /basic/ cells,current_empty_cells,history_position,snapshots!sharing the variables needed for this subroutine except score and the logical ones
	common /logic/ game_over,no_moves!sharing the logical variables
	common /score/ score!sharing the score variable too

	no_cells_moved=.true.!resetting this variable
	do i=0,cells-1
		k=-1!resetting the auxiliary counter so that there are no problems with the cycle statement two lines below
		do j=0,cells-2
			if(k>j)cycle!moving on to the next non null cell in case that there are several non null cells one after the other
			if((matrix(i,j)==matrix(i,j+1)).and.(matrix(i,j)>0))then
				no_cells_moved=.false.!at least one cell has moved
				tag=coordinates_to_index(i,j+1,cells)!storing the index to avoid calling the function more than once
				matrix(i,j)=matrix(i,j)+matrix(i,j+1)!if two adjacent cells have the same value their become one with the sum of their previous values
				if(matrix(i,j)>262144)then
					game_over=.true.!maximum cell value achieved, this game has been won
					return!going back to the main program
				end if
				score=score+matrix(i,j)!updating the score
				matrix(i,j+1)=0!and the cell that was added to the previous one is erased
				current_empty_cells=current_empty_cells+1!one more empty cell
				empty_cells(current_empty_cells-1)=tag!recording the new empty cell
				auxiliary_empty_cells(tag)=current_empty_cells-1!updating the auxiliary empty cells
			else if(matrix(i,j)==0)then
				k=j+1!setting the first auxiliary counter to find the next non null cell
				if(j>0)then
					l=j-1!setting the second auxiliary counter in case there are previous non null cells
				else
					l=j!avoid dangerous indeces
				end if
				exit_1=.false.!resetting this variable for the recursive search below
				exit_2=.false.!same as above
				do
					if((l>0).and.(matrix(i,l)==0))then
						l=l-1!recursively finding the position of the previous non null cell
					else
						exit_1=.true.!first condition for the end of this search
					end if
					if((k==cells-1).and.(matrix(i,k)==0))then
						empty=.true.!the rest of column is empty
						exit!leaving this recursive loop
					end if
					if(matrix(i,k)==0)then
						k=k+1!increasing the counter to keep looking for the next non null cell
					else
						exit_2=.true.!second condition for the end of this search
					end if
					if(exit_1.and.exit_2)exit!unless a non null cell is found, the program will look into the next one
				end do
				if(empty)then
					empty=.false.!resetting the empty trigger variable
					exit!moving on to the next column
				end if
				if(matrix(i,l)==matrix(i,k))then
					no_cells_moved=.false.!at least one cell has moved
					tag=coordinates_to_index(i,k,cells)!storing the index to avoid calling the function more than once
					matrix(i,l)=matrix(i,l)+matrix(i,k)!if two adjacent cells have the same value their become one with the sum of their previous values
					if(matrix(i,l)>262144)then
						game_over=.true.!maximum cell value achieved, this game has been won
						return!going back to the main program
					end if
					score=score+matrix(i,l)!updating the score
					matrix(i,k)=0!and the cell that was added to the previous one is erased
					current_empty_cells=current_empty_cells+1!one more empty cell
					empty_cells(current_empty_cells-1)=tag!recording the new empty cell
					auxiliary_empty_cells(tag)=current_empty_cells-1!updating the auxiliary empty cells
				else
					no_cells_moved=.false.!at least one cell has moved
					if(matrix(i,l)==0)then
						tag=coordinates_to_index(i,l,cells)!storing the index of the empty cell to avoid calling the function more than once
						matrix(i,l)=matrix(i,k)!this cell is moved to the spot held by the empty cell with coordinates (i,j)
					else
						tag=coordinates_to_index(i,l+1,cells)!storing the index of the empty cell to avoid calling the function more than once
						matrix(i,l+1)=matrix(i,k)!this cell is moved to the spot held by the empty cell with coordinates (i,j)
					end if
					tag_extra=coordinates_to_index(i,k,cells)!storing the index of the occupied cell to avoid calling the function more than once
					matrix(i,k)=0!and the cell that was added to the previous one is erased
					empty_cells(auxiliary_empty_cells(tag))=tag_extra!this cell is not empty anymore
					auxiliary_empty_cells(tag_extra)=auxiliary_empty_cells(tag)!and conversely, the cell that is now empty should have its index stored in the right place
					auxiliary_empty_cells(tag)=-1!the cell that is not empty anymore should be marked accordingly
				end if
			end if
		end do
	end do
	if(no_cells_moved)return!going back to the main program
	score_history(history_position)=score!recording the current score in the history
	random_component=nint(rand()*dble(current_empty_cells-1),4)!selecting a new cell to fill it with a number
	new_cell_index=empty_cells(random_component)!the index of the new cell
	new_cell_first_coordinate=index_to_first_coordinate(new_cell_index,cells)!x coordinate of the new cell
	new_cell_second_coordinate=index_to_second_coordinate(new_cell_index,cells)!y coordinate of the new cell
	call check_cells(cells,new_cell_first_coordinate,new_cell_second_coordinate,matrix,new_value)!getting the value for the new cell
	matrix(new_cell_first_coordinate,new_cell_second_coordinate)=new_value!and setting it in the matrix
	empty_cells(random_component)=empty_cells(current_empty_cells-1)!this cell is not empty anymore, so the last empty cell in the array takes up its place
	auxiliary_empty_cells(empty_cells(current_empty_cells-1))=random_component!updating the position of the previous cell in the auxiliary array
	empty_cells(current_empty_cells-1)=-1!this information is not useful anymore, so it's deleted
	auxiliary_empty_cells(new_cell_index)=-1!this index corresponds to a cell marked as empty in the empty_cells vector
	current_empty_cells=current_empty_cells-1!updating the amount of empty cells
	current_empty_cells_history(history_position)=current_empty_cells!storing this value in the history
	call output(cells,matrix)!updating what the player sees in the screen
	do j=0,cells-1
		do i=0,cells-1
			matrix_history(i,j,history_position)=matrix(i,j)!saving the movement
		end do
	end do
	do i=0,cells**2-1
		empty_cells_history(i,history_position)=empty_cells(i)!saving the empty_cells array to the history
		auxiliary_empty_cells_history(i,history_position)=auxiliary_empty_cells(i)!and doing the same for the auxiliary array auxiliar
	end do
	if(current_empty_cells==0)then
		call check_moves(cells,matrix,no_moves)!checking if there are any movements left when there are no empty cells
		if(no_moves)then
			game_over=.true.!no more empty cells, so this game has finished
			no_moves=.false.!resetting this variable to its default value
			return!going back to the main program
		end if
	end if
	history_position=history_position+1!moving on to the next position in the history of movements
	if(history_position>99)history_position=0!going back to the beginning of the history to overwrite the oldest movements
	if(snapshots<100)snapshots=snapshots+1!adding another snapshot if the history is not full
	return
end subroutine move_down