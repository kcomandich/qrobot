require 'readline'
QUIT_COMMANDS = %w[ quit exit ]
VALID_COMMANDS = %w[ quit place move left right report ]
FACING = %i[ north south east west ]
RED = "\e[31m%s\e[0m"

class Robot
  attr_accessor :x_coord, :y_coord, :facing

  def initialize
    @x_coord = 0
    @y_coord = 0
    @facing = :north
  end

  def self.error(msg)
    return format RED, "#{msg}\n"
  end

  def accept_commands
    command = nil
    while command != 'quit'
      command = Readline.readline(" ", true)
      break if QUIT_COMMANDS.include? command.downcase

      handle_command(command)
    end
  end

  def handle_command(full_command)
    command = full_command.split[0].downcase
    args = full_command.split[1]
    unless VALID_COMMANDS.include? command
      STDERR.puts Robot.error 'Invalid option'
      return
    end

    case command
    when 'place'
      # TODO error if no args
      @x_coord = args.split(',')[0]
      @y_coord = args.split(',')[1]
      # TODO error checking for allowed coordinates
      @facing = args.split(',')[2]
    when 'report'
      puts "X: #{@x_coord} Y: #{@y_coord}, Facing: #{@facing}"
    end
  end
end
