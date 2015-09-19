subroutine check_cells(cells,first_coordinate,second_coordinate,matrix,final)
	implicit none!all variables must be declared
	integer(4),intent(in)::cells!number of cells per side of the square to be used in the game
	integer(4),intent(in)::first_coordinate!x coordinate of the selected cell
	integer(4),intent(in)::matrix(0:15,0:15)!all the number cells are here
	integer(4),intent(in)::second_coordinate!y coordinate of the selected cell
	integer(4),intent(out)::final!the output result will be here

	if((first_coordinate==0).and.(second_coordinate==0))then
		if((matrix(first_coordinate+1,second_coordinate)>2).and.(matrix(first_coordinate,second_coordinate+1)>2))then
			final=4!generating a higher value for the final result if all the neighbouring cells have values higher than 2
		else
			if(rand()>0.95)then
				final=4!generating a higher value for the final result in 1 case out of every 20
			else
				final=2!generating a value for the final result
			end if
		end if
	else if((second_coordinate==0).and.((first_coordinate>0).and.(first_coordinate<cells-1)))then
		if(((matrix(first_coordinate-1,second_coordinate)>2).and.(matrix(first_coordinate+1,second_coordinate)>2)).and.(matrix(first_coordinate,second_coordinate+1)>2))then
			final=4!generating a higher value for the final result if all the neighbouring cells have values higher than 2
		else
			if(rand()>0.95)then
				final=4!generating a higher value for the final result in 1 case out of every 20
			else
				final=2!generating a value for the final result
			end if
		end if
	else if((first_coordinate==cells-1).and.(second_coordinate==0))then
		if((matrix(first_coordinate-1,second_coordinate)>2).and.(matrix(first_coordinate,second_coordinate+1)>2))then
			final=4!generating a higher value for the final result if all the neighbouring cells have values higher than 2
		else
			if(rand()>0.95)then
				final=4!generating a higher value for the final result in 1 case out of every 20
			else
				final=2!generating a value for the final result
			end if
		end if
	else if((first_coordinate==cells-1).and.((second_coordinate>0).and.(second_coordinate<cells-1)))then
		if(((matrix(first_coordinate,second_coordinate-1)>2).and.(matrix(first_coordinate,second_coordinate+1)>2)).and.(matrix(first_coordinate-1,second_coordinate)>2))then
			final=4!generating a higher value for the final result if all the neighbouring cells have values higher than 2
		else
			if(rand()>0.95)then
				final=4!generating a higher value for the final result in 1 case out of every 20
			else
				final=2!generating a value for the final result
			end if
		end if
	else if((first_coordinate==cells-1).and.(second_coordinate==cells-1))then
		if((matrix(first_coordinate-1,second_coordinate)>2).and.(matrix(first_coordinate,second_coordinate-1)>2))then
			final=4!generating a higher value for the final result if all the neighbouring cells have values higher than 2
		else
			if(rand()>0.95)then
				final=4!generating a higher value for the final result in 1 case out of every 20
			else
				final=2!generating a value for the final result
			end if
		end if
	else if((second_coordinate==cells-1).and.((first_coordinate>0).and.(first_coordinate<cells-1)))then
		if(((matrix(first_coordinate-1,second_coordinate)>2).and.(matrix(first_coordinate+1,second_coordinate)>2)).and.(matrix(first_coordinate,second_coordinate-1)>2))then
			final=4!generating a higher value for the final result if all the neighbouring cells have values higher than 2
		else
			if(rand()>0.95)then
				final=4!generating a higher value for the final result in 1 case out of every 20
			else
				final=2!generating a value for the final result
			end if
		end if
	else if((first_coordinate==0).and.(second_coordinate==cells-1))then
		if((matrix(first_coordinate+1,second_coordinate)>2).and.(matrix(first_coordinate,second_coordinate-1)>2))then
			final=4!generating a higher value for the final result if all the neighbouring cells have values higher than 2
		else
			if(rand()>0.95)then
				final=4!generating a higher value for the final result in 1 case out of every 20
			else
				final=2!generating a value for the final result
			end if
		end if
	else if((first_coordinate==0).and.((second_coordinate>0).and.(second_coordinate<cells-1)))then
		if(((matrix(first_coordinate,second_coordinate-1)>2).and.(matrix(first_coordinate,second_coordinate+1)>2)).and.(matrix(first_coordinate+1,second_coordinate)>2))then
			final=4!generating a higher value for the final result if all the neighbouring cells have values higher than 2
		else
			if(rand()>0.95)then
				final=4!generating a higher value for the final result in 1 case out of every 20
			else
				final=2!generating a value for the final result
			end if
		end if
	else
		if(((matrix(first_coordinate,second_coordinate-1)>2).and.(matrix(first_coordinate-1,second_coordinate)>2)).and.((matrix(first_coordinate+1,second_coordinate)>2).and.(matrix(first_coordinate,second_coordinate+1)>2)))then
			final=4!generating a higher value for the final result if all the neighbouring cells have values higher than 2
		else
			if(rand()>0.95)then
				final=4!generating a higher value for the final result in 1 case out of every 20
			else
				final=2!generating a value for the final result
			end if
		end if
	end if
	return
end subroutine check_cells