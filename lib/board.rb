require 'thread'
require_relative 'cell'

# Board. Place where game happens.
class Board
  
  # Current state of cells on board. A HashSet is a collection that contains no duplicate elements.
  @current_state = nil
  
  # Temporary HashSet used to checking if new cell should be born.
  @tmp_checked_cell = nil
  
  # Temporary queue used to collect all cells which will be born in next state. LinkedList use FIFO.
  @next_state_give_life = nil
  
  # Temporary queue used to collect all cells which will be kill in next state.
  @next_state_kill_life = nil
  
  # Counter of method run at one stage.
  attr_reader :counter_method_give_life_to_neighbours_if_possible;
  
  # Constructor
  def initialize
    @counter_method_give_life_to_neighbours_if_possible = 0;
    @current_state = Hash.new
    @tmp_checked_cell = Hash.new
    @next_state_give_life = Queue.new
    @next_state_kill_life = Queue.new
  end
  
  # Add new cell to board if it isn't there.
  # @param x
  # @param y
  def add_cell(wartosc_x, wartosc_y)
    cell = Cell.new(wartosc_x, wartosc_y)    
    @current_state[cell.hash_code] = cell
  end
  
  # Remove cell from board.
  # @param x
  # @param y
  def remove_cell(wartosc_x, wartosc_y)
    #@current_state.delete_if {|key, value| value == Cell.new(wartosc_x, wartosc_y) }
    @current_state.delete(Cell.new(wartosc_x, wartosc_y).hash_code)
  end
  
  # Print board as string
  def print_current_state
    @current_state.to_s
  end
  
  # Check is cell exist on board.
  # @param x
  # @param y
  # @return boolean
  def is_cell_exist(wartosc_x, wartosc_y)
    #@current_state.contains(Cell.new(wartosc_x, wartosc_y))
    #@current_state.any? {|k| k == (Cell.new(wartosc_x, wartosc_y)).hash_code}
    @current_state.has_value?(Cell.new(wartosc_x, wartosc_y))
  end
  
  # Return current amount of cells on board.
  # @return int
  def count_cells
    @current_state.size
  end
  
  # Calculate next state of game and set it as current state.
  def next_state
    # set to zero every time when we run next_state method
    counter_method_give_life_to_neighbours_if_possible = 0

    tmp_neighbours = 0
        
    @current_state.each do |key, cell|
      tmp_neighbours = count_neighbours(cell.wartosc_x, cell.wartosc_y)
      if tmp_neighbours < 2 || tmp_neighbours > 3
        # add cell to kill queue
        add_cell_to_next_state_kill_life(cell)
      end
      
      # checking if dead neighbours can be born
      give_life_to_neighbours_if_possible(cell.wartosc_x, cell.wartosc_y)

      # clear temp Hash used in above method
      @tmp_checked_cell.clear
    end

    # kill cells
    while @next_state_kill_life.size > 0 
      # Retrieves and removes the head of this queue, or returns null if this queue is empty.
      tmp_cell = @next_state_kill_life.pop
      remove_cell(tmp_cell.wartosc_x, tmp_cell.wartosc_y)
    end
    
    # born cells
    while @next_state_give_life.size > 0
      tmp_cell = @next_state_give_life.pop
      add_cell(tmp_cell.wartosc_x, tmp_cell.wartosc_y)
    end
  end
  
  # Check if dead neighbours can be born. Only dead cells which had 3 living neighbours can be born.
  # @param x
  # @param y
  def give_life_to_neighbours_if_possible(wartosc_x, wartosc_y)
    @counter_method_give_life_to_neighbours_if_possible += 1

    # 1,1 2,1 3,1
    # 1,2 2,2 3,2
    # 1,3 2,3 3,3
    tmp_x = 0;
    tmp_y = 0;
    x_coeff = [-1, 0, 1, -1, 1, -1, 0, 1]
    y_coeff = [-1, -1, -1, 0, 0, 1, 1, 1]
    for i in 0..7
         tmp_x = wartosc_x + x_coeff[i]
         tmp_y = wartosc_y + y_coeff[i]

      cell = Cell.new(tmp_x, tmp_y) 

      # checking is cell already checked and negative of cell because checking if only dead cell can be born
      if !@tmp_checked_cell.has_value?(cell) && !is_cell_exist(tmp_x, tmp_y) && count_neighbours(tmp_x, tmp_y) == 3 
        # born dead cell
        add_cell_to_next_state_give_life(cell)
      end

      # mark tmp_x tmp_y as cell that we already checked
      @tmp_checked_cell[cell.hash_code] = cell
    end
  end
  
  # Count neighbours of cell.
  # @param x
  # @param y
  # @return int
  def count_neighbours(wartosc_x, wartosc_y)
    # 1,1 2,1 3,1
    # 1,2 2,2 3,2
    # 1,3 2,3 3,3    
    neighbours = 0

	values_x = [-1,0,1]
	values_y = [-1,0,1]
	
	for i in 0..2
		for j in 0..2
			if is_cell_exist(wartosc_x + values_x[i], wartosc_y + values_y[j])
				neighbours +=1
			end
		end
	end
	
    return neighbours
  end
  
  # Adding cell to cells queue. This cells will be kill in next state of game.
  # @param Cell
  def add_cell_to_next_state_kill_life(cell)
    @next_state_kill_life.push(cell) # adding    
  end
  
  # Adding cell to cells queue. This cells will be born in next state of game.
  # @param Cell
  def add_cell_to_next_state_give_life(cell)
    @next_state_give_life.push(cell) # adding    
  end
  
end
