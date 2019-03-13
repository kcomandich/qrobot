require 'readline'
require 'robot'

QUIT_COMMANDS = %w[ QUIT EXIT ]
VALID_COMMANDS = %w[ QUIT PLACE MOVE LEFT RIGHT REPORT ]
RED = "\e[31m%s\e[0m"

class Simulator
  attr_accessor :robot

  def initialize
    @robot = Robot.new
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
      robot.place(args)
    when 'MOVE'
      robot.move
    when 'LEFT'
      robot.left
    when 'RIGHT'
      robot.right
    when 'REPORT'
      robot.report
    end
  end
end

