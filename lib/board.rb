VALID_COORDINATES = [ 0, 1, 2, 3, 4 ]
class Board

  def self.valid_coordinates(x, y)
    return false unless VALID_COORDINATES.include? x.to_i
    return false unless VALID_COORDINATES.include? y.to_i
    return true
  end
end
