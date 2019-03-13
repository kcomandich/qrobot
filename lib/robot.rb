require 'board'

VALID_DIRECTIONS = %w[ NORTH EAST SOUTH WEST ] # ordered from left to right

class Robot
  attr_accessor :board, :x_coord, :y_coord, :facing

  def initialize
    @board = Board.new([ 0, 1, 2, 3, 4 ])
    @x_coord = nil
    @y_coord = nil
    @facing = nil
  end

  def self.valid_facing(direction)
    return false unless VALID_DIRECTIONS.include? direction
    return true
  end

  def is_on_board
    if @x_coord and @y_coord and @facing
      return true
    else
      STDERR.puts Simulator.error 'Robot is not on the board. Use the PLACE command to start the robot.'
      return false
    end
  end

  def move
    return unless is_on_board

    x = @x_coord
    y = @y_coord
    case @facing
    when 'EAST'
      x = @x_coord + 1
    when 'WEST'
      x = @x_coord - 1
    when 'NORTH'
      y = @y_coord + 1
    when 'SOUTH'
      y = @y_coord - 1
    end
    if board.valid_coordinates(x, y)
      @x_coord = x
      @y_coord = y
    else
      STDERR.puts Simulator.error "Robot can't go over the edge of the board, robot not moved"
    end
  end

  def right
    return unless is_on_board

    # VALID_DIRECTIONS array is ordered from left to right
    # to turn RIGHT, go to the next item in the array
    current_facing_index = VALID_DIRECTIONS.index(@facing)
    if current_facing_index < VALID_DIRECTIONS.count-1
      @facing = VALID_DIRECTIONS[current_facing_index+1]
    else
      # (or loop around to the beginning if we're at the end)
      @facing = VALID_DIRECTIONS[0]
    end
  end

  def left
    return unless is_on_board

    # VALID_DIRECTIONS array is ordered from left to right
    # to turn LEFT, go one item back in the array
    current_facing_index = VALID_DIRECTIONS.index(@facing)
    if current_facing_index > 0
      @facing = VALID_DIRECTIONS[current_facing_index-1]
    else
      # (or jump to the end of the array if we're at the beginning)
      @facing = VALID_DIRECTIONS[VALID_DIRECTIONS.count - 1]
    end
  end

  def place(args)
    unless args
      STDERR.puts Simulator.error 'PLACE command requires coordinates and facing direction, robot not moved'
      return
    end
    x, y, direction = args.upcase.split(',')
    if board.valid_coordinates(x, y) and Robot.valid_facing(direction)
      @x_coord = x.to_i
      @y_coord = y.to_i
      @facing = direction
    else
      STDERR.puts Simulator.error 'Invalid position, robot not moved'
    end
  end

  def report
    return unless is_on_board

    puts "X: #{@x_coord} Y: #{@y_coord}, Facing: #{@facing}"
  end
end
