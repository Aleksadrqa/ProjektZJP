#
# Copyright (C) 2012 Artur Trzop. MIT License.
# 

require_relative 'board'
require_relative 'board_console_visualizer'


puts "Game of Life in Ruby"


#b = BoardConsoleVisualizer.new # default settings
b = BoardConsoleVisualizer.new(7, 250, false)

# display settings
puts b.area_size
puts b.time_sleep
puts b.display_current_coordinates


# set your own size of board in constructor or override it here
b.area_size = 7


# Set cells coordinates here

# toad vertical
# http://en.wikipedia.org/wiki/File:Game_of_life_toad.gif
b.add_cell(1, 1)
b.add_cell(1, 2)
b.add_cell(1, 3)
b.add_cell(2, 2)
b.add_cell(2, 3)
b.add_cell(2, 4)

# tub
# http://pl.wikipedia.org/wiki/Plik:JdlV_bloc_4.9.gif
b.add_cell(-5, 0)
b.add_cell(-5, 2)
b.add_cell(-6, 1)
b.add_cell(-4, 1)

# glider
# http://en.wikipedia.org/wiki/File:Game_of_life_animated_glider.gif
b.add_cell(-18, -5)
b.add_cell(-18, -4)
b.add_cell(-18, -3)
b.add_cell(-19, -3)
b.add_cell(-20, -4)

# blinker
# http://en.wikipedia.org/wiki/File:Game_of_life_blinker.gif
b.add_cell(10, 0)
b.add_cell(11, 0)
b.add_cell(12, 0)

# blinker
b.add_cell(-10, 5)
b.add_cell(-10, 6)
b.add_cell(-10, 7)


# 100 random cells
for i in 1..100
  random_x = Random.rand(20 - -20 + 1) + -20
  random_y = Random.rand(20 - -20 + 1) + -20
  
  b.add_cell(random_x, random_y)
end



# START RunGameExample1
# # display board
# b.display_current_state_of_board()
# 
# # display coordinates of cells
# b.print_current_state_coordinates()
# 
# # calculate next state of game
# b.next_state()
# 
# # and print board :)
# b.display_current_state_of_board()
# 
# # pause befor start game
# sleep(2)
# END RunGameExample2 


# START RunGameExample2
# run game in infinity loop
b.play_game()
# END RunGameExample2


# START RunGameExample3
# shows amount of cells and attempts to give life at step
# for i in 0..100
  # b.next_state()
  # puts "Step #{i}, Cells on board: #{b.count_cells}, Attempts to give life: #{b.counter_method_give_life_to_neighbours_if_possible}"
# end
# END RunGameExample3