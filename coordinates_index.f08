integer(4) function coordinates_to_index(i,j,cells)
	implicit none!all variables must be declared
	integer(4),intent(in)::cells!number of cells per side of the square to be used in the game
	integer(4),intent(in)::i!first coordinate
	integer(4),intent(in)::j!second coordinate
	coordinates_to_index=j*cells+i!the conversion
end function coordinates_to_index



integer(4) function index_to_first_coordinate(i,cells)
	implicit none!all variables must be declared
	integer(4),intent(in)::cells!number of cells per side of the square to be used in the game
	integer(4),intent(in)::i!index of the cell
	index_to_first_coordinate=mod(i,cells)!the conversion
end function index_to_first_coordinate



integer(4) function index_to_second_coordinate(i,cells)
	implicit none!all variables must be declared
	integer(4),intent(in)::cells!number of cells per side of the square to be used in the game
	integer(4),intent(in)::i!index of the cell
	index_to_second_coordinate=i/cells!the conversion
end function index_to_second_coordinate