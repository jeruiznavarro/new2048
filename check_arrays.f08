subroutine check_arrays(auxiliary_empty_cells,current_empty_cells,empty_cells,error_index)
	implicit none
	integer(4),intent(in)::auxiliary_empty_cells(0:255)!this vector keeps track of where the index of a certain cell is located in the empty_cells array, for example: empty_cells(0:3)=(/1,3,0,2/) would mean that the values of this array are the following: auxiliary_empty_cells(0:3)=(/2,0,1,3/), thus, only the index of a cell is needed when its interal data are required
	integer(4),intent(in)::current_empty_cells!this is the amount of empty cells in a certain moment
	integer(4),intent(in)::empty_cells(0:255)!the indeces of empty cells are sequentially kept here with no occupied cells in between, all of those are at the end of the array
	integer(4),intent(out)::error_index!if there is an error in the arrays, the index of the cell associated with the error will be released as output in this variable
	integer(4)::i=0!auxiliary counter

	do i=0,current_empty_cells-1
		if(i/=auxiliary_empty_cells(empty_cells(i)))then
			error_index=empty_cells(i)!there is an error here and the cell is recorded
			return
		else
			error_index=-1!no error detected
		end if
	end do
	return
end subroutine check_arrays



!	call check_arrays(auxiliary_empty_cells,current_empty_cells,empty_cells,error_index)!checking if there's inconsistencies in the auxiliary_empty_cells and empty_cells arrays
!	if(error_index/=-1)then
!		write(*,*) 'Error detected in cell:',error_index!output for the error
!	end if