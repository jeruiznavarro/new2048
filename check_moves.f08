subroutine check_moves(cells,matrix,no_moves)
	implicit none
	logical,intent(out)::no_moves!if true, it will mean that there are no possible movements left
	integer(4),intent(in)::cells!number of cells per side of the square to be used in the game
	integer(4)::i=0!first auxiliary index for the matrix
	integer(4)::j=0!second auxiliary index for the matrix
	integer(4),intent(in)::matrix(0:15,0:15)!all the number cells are here

	do j=0,cells-1
		do i=0,cells-1
			if((i==0).and.(j==0))then
				if((matrix(i,j)==matrix(i+1,j)).or.(matrix(i,j)==matrix(i,j+1)))then
					no_moves=.false.!there is at least one possible movement
					return
				end if
			else if((j==0).and.((i>0).and.(i<cells-1)))then
				if((matrix(i,j)==matrix(i,j+1)).or.((matrix(i,j)==matrix(i-1,j)).or.(matrix(i,j)==matrix(i+1,j))))then
					no_moves=.false.!there is at least one possible movement
					return
				end if
			else if((i==cells-1).and.(j==0))then
				if((matrix(i,j)==matrix(i-1,j)).or.(matrix(i,j)==matrix(i,j+1)))then
					no_moves=.false.!there is at least one possible movement
					return
				end if
			else if((i==cells-1).and.((j>0).and.(j<cells-1)))then
				if((matrix(i,j)==matrix(i-1,j)).or.((matrix(i,j)==matrix(i,j-1)).or.(matrix(i,j)==matrix(i,j+1))))then
					no_moves=.false.!there is at least one possible movement
					return
				end if
			else if((i==cells-1).and.(j==cells-1))then
				if((matrix(i,j)==matrix(i-1,j)).or.(matrix(i,j)==matrix(i,j-1)))then
					no_moves=.false.!there is at least one possible movement
					return
				end if
			else if((j==cells-1).and.((i>0).and.(i<cells-1)))then
				if((matrix(i,j)==matrix(i,j-1)).or.((matrix(i,j)==matrix(i-1,j)).or.(matrix(i,j)==matrix(i+1,j))))then
					no_moves=.false.!there is at least one possible movement
					return
				end if
			else if((i==0).and.(j==cells-1))then
				if((matrix(i,j)==matrix(i+1,j)).or.(matrix(i,j)==matrix(i,j-1)))then
					no_moves=.false.!there is at least one possible movement
					return
				end if
			else if((i==0).and.((j>0).and.(j<cells-1)))then
				if((matrix(i,j)==matrix(i+1,j)).or.((matrix(i,j)==matrix(i,j-1)).or.(matrix(i,j)==matrix(i,j+1))))then
					no_moves=.false.!there is at least one possible movement
					return
				end if
			else
				if(((matrix(i,j)==matrix(i-1,j)).or.(matrix(i,j)==matrix(i+1,j))).or.((matrix(i,j)==matrix(i,j-1)).or.(matrix(i,j)==matrix(i,j+1))))then
					no_moves=.false.!there is at least one possible movement
					return
				end if
			end if
		end do
	end do
	no_moves=.true.!after checking all the cells, there are no possible movements
	return
end subroutine check_moves