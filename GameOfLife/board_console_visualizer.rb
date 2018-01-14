require_relative 'board'
require_relative 'i_board_visualizer'

class BoardConsoleVisualizer < Board
  include IBoardVisualizer
  
  # Size of board in vertical. Horizontal size is 4 times bigger than @area_size
  attr_accessor :area_size
  
  # Milliseconds between next refresh of game state.
  attr_accessor :time_sleep
  
  # If true then write on console information about coordinates of all cells after each state of loop in play_game method.
  attr_accessor :display_current_coordinates
  
  # Constructor with settings.
  # @param area_size Integer
  # @param time_sleep In miliseconds.
  # @param display_current_coordinates boolean
  def initialize(area_size = 0, time_sleep = 0, display_current_coordinates = false)
    # run base constructor without args. () means no args
    super()
    
    if area_size > 0
      @area_size = area_size
    else
      @area_size = 5
    end
    
    if time_sleep > 0
      @time_sleep = time_sleep
    else
      @time_sleep = 250
    end
    
    @display_current_coordinates = display_current_coordinates    
  end
  
  # Write on console information about coordinates of all cells.
  def print_current_state_coordinates
    puts
    
    @current_state.each do |key, cell|
      puts "X: #{cell.x}, Y: #{cell.y}"
    end
    
    puts "Cells on board #{@current_state.size}"
  end
  
  # Write on console all cells in visual way.
  def display_current_state_of_board
    puts
    
    for i in -@area_size..@area_size*2 do
      for j in -@area_size*4..@area_size*4 do
        if is_cell_exist(j, i)
          print 'O'
        else
          print ' '
        end
      end
      puts
    end
    
    puts "Cells on board #{@current_state.size}"    
  end
  
  # Play game in infinity loop.
  def play_game
    display_current_state_of_board()
    
    if @display_current_state_of_board
      print_current_state_coordinates()
    end
    
    sleep(@time_sleep/1000.0)
    
    while true
      system 'cls'
      
      next_state()
      display_current_state_of_board()
      
      if @display_current_state_of_board
        print_current_state_coordinates()
      end
      
      sleep(@time_sleep/1000.0)      
    end
  end
    
end