require 'robot'

RSpec.describe Robot do

  describe '#accept_commands' do
    it "quits when the user chooses quit" do
      allow(Readline).to receive(:readline).exactly(1).times.and_return('quit')
      r = Robot.new
    end
    
    it 'reports the coordinates and facing position' do
      allow(Readline).to receive(:readline).exactly(3).times.and_return('PLACE 1,2,NORTH', 'REPORT', 'quit')
      r = Robot.new
      expect{r.accept_commands}.to output(/X: 1 Y: 2, Facing: NORTH/).to_stdout 
    end
  end
end
