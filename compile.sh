#!/bin/bash
gfortran -Wall -Wextra -Wtabs -mcmodel=large -fPIC -g -fcheck=all -fbacktrace -ffree-line-length-0 check_cells.f08 check_moves.f08 coordinates_index.f08 end_game.f08 help.f08 load_game.f08 main.f08 move_back.f08 move_down.f08 move_left.f08 move_right.f08 move_up.f08 new_game.f08 output.f08 prompt_player.f08 save_game.f08 start.f08 -o 262144_debug.exe
gfortran -Wall -Wextra -Wtabs -mcmodel=large -fPIC -O3 -march=native -ffast-math -funroll-loops -ffree-line-length-0 check_cells.f08 check_moves.f08 coordinates_index.f08 end_game.f08 help.f08 load_game.f08 main.f08 move_back.f08 move_down.f08 move_left.f08 move_right.f08 move_up.f08 new_game.f08 output.f08 prompt_player.f08 save_game.f08 start.f08 -o 262144.exe