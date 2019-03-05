require 'readline'

FACING = %i( north south east west )
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
      break if %w[ quit exit ].include? command
    end
  end
end
