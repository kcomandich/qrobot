require 'robot'

RSpec.describe Robot do

  describe '#accept_commands' do
    it "quits when the user chooses quit" do
      allow(Readline).to receive(:readline).exactly(1).times.and_return('quit')
      r = Robot.new
    end

    it 'remembers the placed position' do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('PLACE 0,4,SOUTH', 'quit')
      r = Robot.new
      r.accept_commands
      expect(r.x_coord).to eq(0)
      expect(r.y_coord).to eq(4)
      expect(r.facing).to eq('SOUTH')
    end

    it 'ignores the PLACE command if there are no args' do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('PLACE', 'quit')
      r = Robot.new
      r.accept_commands
      expect(r.x_coord).to be nil
      expect(r.y_coord).to be nil
      expect(r.facing).to be nil
    end

    it 'ignores the PLACE command if the coordinates take the robot off the defined board limits' do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('PLACE 0,9', 'quit')
      r = Robot.new
      r.accept_commands
      expect(r.x_coord).to be nil
      expect(r.y_coord).to be nil
      expect(r.facing).to be nil
    end

    it 'ignores all commands until a valid PLACE command is run' do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('REPORT', 'quit')
      r = Robot.new
      expect{r.accept_commands}.to_not output.to_stdout
    end

    it 'reports the coordinates and facing position' do
      allow(Readline).to receive(:readline).exactly(3).times.and_return('PLACE 1,2,NORTH', 'REPORT', 'quit')
      r = Robot.new
      expect{r.accept_commands}.to output(/X: 1 Y: 2, Facing: NORTH/).to_stdout
    end

    it 'moves the robot one unit forward in the direction it is currently facing' do
      allow(Readline).to receive(:readline).exactly(4).times.and_return('PLACE 0,0,EAST', 'MOVE', 'REPORT', 'quit')
      r = Robot.new
      expect{r.accept_commands}.to output(/X: 1 Y: 0, Facing: EAST/).to_stdout
    end

    it 'changes the direction the robot is facing LEFT' do
      allow(Readline).to receive(:readline).exactly(4).times.and_return('PLACE 0,0,NORTH', 'LEFT', 'REPORT', 'QUIT')
      r = Robot.new
      expect{r.accept_commands}.to output(/X: 0 Y: 0, Facing: WEST/).to_stdout
    end

    it 'changes the direction the robot is facing RIGHT' do
      allow(Readline).to receive(:readline).exactly(4).times.and_return('PLACE 0,0,NORTH', 'RIGHT', 'REPORT', 'QUIT')
      r = Robot.new
      expect{r.accept_commands}.to output(/X: 0 Y: 0, Facing: EAST/).to_stdout
    end
  end
end
