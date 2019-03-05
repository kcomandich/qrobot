require 'readline'
QUIT_COMMANDS = %w[ QUIT EXIT ]
VALID_COMMANDS = %w[ QUIT PLACE MOVE LEFT RIGHT REPORT ]
VALID_COORDINATES = %w[ 0 1 2 3 4 ]
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
      x, y, facing = args.upcase.split(',')
      if check_place_args(x, y, facing)
        @x_coord = x 
        @y_coord = y 
        @facing = facing 
      end
    when 'REPORT'
      puts "X: #{@x_coord} Y: #{@y_coord}, Facing: #{@facing}"
    end
  end

  def check_place_args(x, y, facing)
    return false unless VALID_COORDINATES.include? x 
    return false unless VALID_COORDINATES.include? y 
    return false unless VALID_FACING.include? facing
    return true
  end
end
