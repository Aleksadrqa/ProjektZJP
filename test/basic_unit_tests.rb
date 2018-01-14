# http://en.wikibooks.org/wiki/Ruby_Programming/Unit_testing

require "test/unit"
require_relative '../GameOfLife/board'

class BasicUnitTests < Test::Unit::TestCase
 
  def test_should_cell_exist_when_was_added
    b = Board.new
    b.add_cell(1, 1)
    
    assert_equal(true, b.is_cell_exist(1, 1))
  end
  
  def test_should_cell_not_exist_when_was_removed
    b = Board.new
    b.add_cell(1, 1)
    b.remove_cell(1, 1)
    
    assert_equal(false, b.is_cell_exist(1, 1))
  end
  
  def test_should_one_cell_exist_when_added_two_times_the_same_cell
    b = Board.new
    b.add_cell(1, 1)
    b.add_cell(1, 1)
    
    assert_equal(1, b.count_cells)
  end
  
  def test_should_board_has_zero_cells_when_its_empty
    b = Board.new
    
    assert_equal(0, b.count_cells)
  end
  
  def test_should_cell_die_when_is_lonely
    b = Board.new
    b.add_cell(1, 1)
    b.next_state
    
    assert_equal(false, b.is_cell_exist(1, 1))
  end
  
  def test_should_living_cell_still_live_when_has_two_or_three_neighbours
    # test for two neighbours
    b = Board.new
    b.add_cell(2, 2)
    b.add_cell(3, 2)
    b.add_cell(2, 3)
    b.next_state

    assert_equal(true, b.is_cell_exist(2, 2))

    # test for three neighbours
    b = Board.new
    b.add_cell(2, 2)
    b.add_cell(3, 2)
    b.add_cell(2, 3)
    b.add_cell(3, 3)
    b.next_state

    assert_equal(true, b.is_cell_exist(2, 2))
  end
  
  def test_should_living_cell_die_when_has_less_than_two_neighbours
    b = Board.new
    b.add_cell(2, 2)
    b.add_cell(3, 2)
    b.next_state

    assert_equal(false, b.is_cell_exist(2, 2))
  end
  
  def test_should_living_cell_die_when_has_more_than_three_neighbours
    b = Board.new    
    b.add_cell(2, 2)
    b.add_cell(3, 2)
    b.add_cell(2, 3)
    b.add_cell(3, 3)
    b.add_cell(1, 3)
    b.next_state
    
    assert_equal(false, b.is_cell_exist(2, 2))    
  end
  
  def test_count_cell_neighbours
    b = Board.new 
    b.add_cell(2, 2)
    b.add_cell(3, 2)

    assert_equal(2, b.count_neighbours(3, 3))
  end
  
  def test_count_cells_on_board
    b = Board.new
    b.add_cell(-2, 4)
    b.add_cell(45, -2)
    b.add_cell(5, 23)
    b.add_cell(0, -5)
    b.add_cell(-23, -23)
    
    assert_equal(5, b.count_cells)    
  end
  
  def test_should_cells_be_equal_when_have_the_same_coordinates
    c1 = Cell.new(1, 2)
    c2 = Cell.new(1, 2)
    
    assert_equal(c1, c2)
  end
  
  def test_should_cells_be_not_equal_when_have_different_coordinates
    c1 = Cell.new(1, 2)
    c2 = Cell.new(1, 3)
    
    assert_not_equal(c1, c2)
  end
    
end