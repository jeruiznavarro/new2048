subroutine output(cells,matrix)
	implicit none!all variables must be declared
	integer(4),intent(in)::cells!number of cells per side of the square to be used in the game
	integer(4)::i=0!first auxiliary index for the matrix
	integer(4)::j=0!second auxiliary index for the matrix
	integer(4),intent(in)::matrix(0:15,0:15)!all the number cells are here

	open(10,file='matrix_output.dat',status='replace')!the matrix will be kept here so it can be read by gnuplot, the current content will be erased
	do j=0,cells-1
		do i=0,cells-1
			write(10,*) dble(i)+5.d-1,dble(j)+5.d-1,matrix(i,j)!writing the matrix to its file, the coordinates for each cell of the matrix are also included so gnuplot plots them in the right place
		end do
	end do
	close(10)!closing the file so it can be used the next time this subroutine is called
	write(*,*) 'set xrange [0:',cells,']'!setting the limits of the visualization in the x axis
	write(*,*) 'set yrange [0:',cells,']'!setting the limits of the visualization in the y axis
	write(*,*) 'set cbrange [0:262144]'!this is the possible range of colours that the cells can show, a colour gradient between the extremes of that interval will be set
	write(*,*) 'set palette defined ( 0.0 "#FFFFFF", 2.0 "#EEE4DA", 4.0 "#EDE0C8", 8.0 "#F2B179", 16.0 "#F59563", 32.0 "#F67C5F", 64.0 "#F65E3B", 128.0 "#EDCF72", 256.0 "#EDCC61", 512.0 "#EDC850", 1024.0 "#EDC53F", 2048.0 "#EDC22E", 4096.0 "#3E3933", 8192.0 "#3A352F", 16384.0 "#36312B", 32768.0 "#322D27", 65536.0 "#2E2923", 131072.0 "#2A251F", 262144.0 "#26211b" )'!and these are the explicit possible colours, other colours between this range are allowed too since gnuplot will interpolate between the extremes of the range
	write(*,*) 'set view map'!this is necessary to show the colours together with the values of each cell of the matrix
	write(*,*) 'unset colorbox'!the colour box shows the scale defined by the colours of the palette, but it just gets in the way for the game
	write(*,*) "plot 'matrix_output.dat' u 1:2:3 w image, 'matrix_output.dat' u 1:2:(strcol(3)) w labels"!plotting the matrix with the appropiate colours
	return
end subroutine output