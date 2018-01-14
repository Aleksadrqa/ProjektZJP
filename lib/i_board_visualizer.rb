# Interface to visual implementation of game.
module IBoardVisualizer
  
  # Display current state of board on the screen.
  def display_current_state_of_board
    raise "display_current_state_of_board must be overridden"
  end
  
  # Play game in infinity loop  
  def play_game
    raise "play_game must be overridden"
  end
  
end