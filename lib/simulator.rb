require 'readline'
QUIT_COMMANDS = %w[ QUIT EXIT ]
VALID_COMMANDS = %w[ QUIT PLACE MOVE LEFT RIGHT REPORT ]
VALID_COORDINATES = [ 0, 1, 2, 3, 4 ]
VALID_FACING = %w[ NORTH EAST SOUTH WEST ] # ordered from left to right
RED = "\e[31m%s\e[0m"

class Simulator
  attr_accessor :x_coord, :y_coord, :facing

  def initialize
    @x_coord = nil
    @y_coord = nil
    @facing = nil
  end

  def self.error(msg)
    return format RED, "#{msg}\n"
  end

  def intro_text
    puts "Toy Robot Simulator"
    puts "A simulation of a toy robot moving on a square 5x5 board"
    puts "Type 'QUIT' to exit at any time"
    puts "\n"
    puts "(0,0) is the southwest-most corner"
    puts "\n"
    puts "Options:"
    puts "  * PLACE X,Y,F"
    puts "  PLACE will put the robot on the board in position X,Y and facing (F) NORTH, SOUTH, EAST, or WEST"
    puts "  * MOVE will move the robot one unit forward in the direction it is currently facing"
    puts "  * LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot"
    puts "  * REPORT will announce the X, Y and F of the robot"
    puts "\n"
  end

  def accept_commands
    command = nil
    while command != 'quit'
      command = Readline.readline(" ", true)
      break if QUIT_COMMANDS.include? command.upcase

      handle_command(command)
    end
  end

  def handle_command(full_command)
    command = full_command.split[0].upcase
    args = full_command.split[1]
    unless VALID_COMMANDS.include? command
      STDERR.puts Simulator.error 'Invalid option'
      return
    end

    case command
    when 'PLACE'
      place(args)
    when 'MOVE'
      return unless robot_is_on_board
      move
    when 'LEFT'
      return unless robot_is_on_board
      left
    when 'RIGHT'
      return unless robot_is_on_board
      right
    when 'REPORT'
      return unless robot_is_on_board
      report
    end
  end

  def robot_is_on_board
    if @x_coord and @y_coord and @facing
      return true
    else
      STDERR.puts Simulator.error 'Robot is not on the board. Use the PLACE command to start the robot.'
      return false
    end
  end

  def valid_place_args(x, y, facing)
    return false unless VALID_COORDINATES.include? x.to_i
    return false unless VALID_COORDINATES.include? y.to_i
    return false unless VALID_FACING.include? facing
    return true
  end

  def place(args)
    unless args
      STDERR.puts Simulator.error 'PLACE command requires coordinates and facing direction, robot not moved'
      return
    end
    x, y, facing = args.upcase.split(',')
    if valid_place_args(x, y, facing)
      @x_coord = x.to_i
      @y_coord = y.to_i
      @facing = facing
    else
      STDERR.puts Simulator.error 'Invalid position, robot not moved'
    end
  end

  def move
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
    if valid_place_args(x, y, @facing)
      @x_coord = x
      @y_coord = y
    else
      STDERR.puts Simulator.error "Robot can't go over the edge of the board, robot not moved"
    end
 end

  def right
    # VALID_FACING array is ordered from left to right
    # to turn RIGHT, go to the next item in the array
    current_facing_index = VALID_FACING.index(@facing)
    if current_facing_index < VALID_FACING.count-1
      @facing = VALID_FACING[current_facing_index+1]
    else
      # (or loop around to the beginning if we're at the end)
      @facing = VALID_FACING[0]
    end
  end

  def left
    # VALID_FACING array is ordered from left to right
    # to turn LEFT, go one item back in the array
    current_facing_index = VALID_FACING.index(@facing)
    if current_facing_index > 0
      @facing = VALID_FACING[current_facing_index-1]
    else
      # (or jump to the end of the array if we're at the beginning)
      @facing = VALID_FACING[VALID_FACING.count - 1]
    end
  end

  def report
    puts "X: #{@x_coord} Y: #{@y_coord}, Facing: #{@facing}"
  end
end
