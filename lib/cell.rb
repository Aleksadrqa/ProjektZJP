# Structure of cell. Contains coordinates x and y.
class Cell
 # :reek:DuplicateMethodCall { allow_calls: ['prime * result'] }
   attr_reader :wartosc_x, :wartosc_y
  
  # Constructor.
  # @param wartosc_x 
  # @param wartosc_y
  def initialize(wartosc_x, wartosc_y)
    @wartosc_x = wartosc_x
    @wartosc_y = wartosc_y
  end
  
  # Operator == overloading. Important to delete cell from Hash.
  def ==(cell)
    if @wartosc_x == cell.wartosc_x && @wartosc_y == cell.wartosc_y then
      true;
    else
      false;
    end
  end
  
  # When two objects have the same pair x, y then they have the same hash_code.
  def hash_code
    prime = 31
    result = 1
    result = prime * result + wartosc_x
    result = prime * result + wartosc_y
    return result;
  end
  
end
