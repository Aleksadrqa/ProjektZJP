# Structure of cell. Contains coordinates x and y.
class Cell
  
  attr_accessor :x, :y
  
  # Constructor.
  # @param x 
  # @param y
  def initialize(x, y)
    @x = x
    @y = y
  end
  
  # Operator == overloading. Important to delete cell from Hash.
  def ==(cell)
    if @x == cell.x && @y == cell.y then
      true;
    else
      false;
    end
  end
  
  # When two objects have the same pair x, y then they have the same hash_code.
  def hash_code
    prime = 31
    result = 1
    result = prime * result + x
    result = prime * result + y
    return result;
  end
  
end