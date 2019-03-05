require 'readline'
QUIT_COMMANDS = %w[ QUIT EXIT ]
VALID_COMMANDS = %w[ QUIT PLACE MOVE LEFT RIGHT REPORT ]
VALID_COORDINATES = [ 0, 1, 2, 3, 4 ]
VALID_FACING = %w[ NORTH SOUTH EAST WEST ]
RED = "\e[31m%s\e[0m"

class Robot
  attr_accessor :x_coord, :y_coord, :facing

  def initialize
    @x_coord = nil
    @y_coord = nil
    @facing = nil 
  end

  def self.error(msg)
    return format RED, "#{msg}\n"
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
      STDERR.puts Robot.error 'Invalid option'
      return
    end

    case command
    when 'PLACE'
      return unless args
      place(args)
    when 'MOVE'
      return unless robot_is_on_board
      move
    when 'REPORT'
      return unless robot_is_on_board
      report
    end
  end

  def robot_is_on_board
    return false unless @x_coord and @y_coord and @facing
    return true
  end

  def valid_place_args(x, y, facing)
    return false unless VALID_COORDINATES.include? x.to_i
    return false unless VALID_COORDINATES.include? y.to_i
    return false unless VALID_FACING.include? facing
    return true
  end

  def place(args)
    x, y, facing = args.upcase.split(',')
    if valid_place_args(x, y, facing)
      @x_coord = x.to_i
      @y_coord = y.to_i
      @facing = facing
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
    end
  end

  def report
    puts "X: #{@x_coord} Y: #{@y_coord}, Facing: #{@facing}"
  end
end

