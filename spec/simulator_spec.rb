require 'simulator'

RSpec.describe Simulator do

  before :each do
    @s = Simulator.new
  end

  def send_commands(*commands)
    allow(Readline).to receive(:readline).exactly(commands.count).times.and_return(*commands)
  end

  describe '#accept_commands' do
    it "quits when the user chooses quit" do
      send_commands('QUIT')
    end

    it 'ignores the PLACE command if there are no args' do
      send_commands('PLACE', 'QUIT')
      expect{@s.accept_commands}.to output(/robot not moved/).to_stderr_from_any_process
    end

    it 'ignores all commands until a valid PLACE command is run' do
      send_commands('REPORT', 'QUIT')
      expect{@s.accept_commands}.to output(/Robot is not on the board/).to_stderr_from_any_process
    end

    it 'warns if an invalid command is made' do
      send_commands('FAKE', 'QUIT')
      expect{@s.accept_commands}.to output(/Invalid option/).to_stderr_from_any_process
    end
  end
end
