require 'robot'

RSpec.describe Robot do

  describe '#accept_commands' do
    it "quits when the user chooses quit" do
      allow(Readline).to receive(:readline).exactly(1).times.and_return('quit')
      r = Robot.new
    end
  end
end
