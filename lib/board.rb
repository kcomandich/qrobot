class Board
  attr_accessor :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
  end

  def valid_coordinates(x, y)
    return false unless coordinates.include? x.to_i
    return false unless coordinates.include? y.to_i
    return true
  end
end
