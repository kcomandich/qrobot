require 'robot'

RSpec.describe Robot do

  before :each do
    @r = Robot.new
  end

  describe '#accept_commands' do
    it "quits when the user chooses quit" do
      allow(Readline).to receive(:readline).exactly(1).times.and_return('QUIT')
    end

    it 'remembers the placed position' do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('PLACE 0,4,SOUTH', 'QUIT')
      @r.accept_commands
      expect(@r.x_coord).to eq(0)
      expect(@r.y_coord).to eq(4)
      expect(@r.facing).to eq('SOUTH')
    end

    it 'ignores the PLACE command if there are no args' do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('PLACE', 'QUIT')
      expect{@r.accept_commands}.to output(/robot not moved/).to_stderr_from_any_process
      expect(@r.x_coord).to be nil
      expect(@r.y_coord).to be nil
      expect(@r.facing).to be nil
    end

    it 'ignores the PLACE command if the coordinates take the robot off the defined board limits' do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('PLACE 0,9', 'QUIT')
      expect{@r.accept_commands}.to output(/robot not moved/).to_stderr_from_any_process
      expect(@r.x_coord).to be nil
      expect(@r.y_coord).to be nil
      expect(@r.facing).to be nil
    end

    it 'ignores all commands until a valid PLACE command is run' do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('REPORT', 'QUIT')
      expect{@r.accept_commands}.to output(/Robot is not on the board/).to_stderr_from_any_process
    end

    it 'reports the coordinates and facing position' do
      allow(Readline).to receive(:readline).exactly(3).times.and_return('PLACE 1,2,NORTH', 'REPORT', 'QUIT')
      expect{@r.accept_commands}.to output(/X: 1 Y: 2, Facing: NORTH/).to_stdout
    end

    it 'moves the robot one unit forward in the direction it is currently facing' do
      allow(Readline).to receive(:readline).exactly(4).times.and_return('PLACE 0,0,EAST', 'MOVE', 'REPORT', 'QUIT')
      expect{@r.accept_commands}.to output(/X: 1 Y: 0, Facing: EAST/).to_stdout
    end

    it 'warns if MOVE would put the robot off the board and does not move the robot' do
      allow(Readline).to receive(:readline).exactly(3).times.and_return('PLACE 0,0,WEST', 'MOVE', 'QUIT')
      expect{@r.accept_commands}.to output(/robot not moved/).to_stderr_from_any_process
      expect(@r.x_coord).to eq 0
      expect(@r.y_coord).to eq 0
    end

    it 'changes the direction the robot is facing LEFT' do
      allow(Readline).to receive(:readline).exactly(4).times.and_return('PLACE 0,0,NORTH', 'LEFT', 'REPORT', 'QUIT')
      expect{@r.accept_commands}.to output(/X: 0 Y: 0, Facing: WEST/).to_stdout
    end

    it 'changes the direction the robot is facing RIGHT' do
      allow(Readline).to receive(:readline).exactly(4).times.and_return('PLACE 0,0,NORTH', 'RIGHT', 'REPORT', 'QUIT')
      expect{@r.accept_commands}.to output(/X: 0 Y: 0, Facing: EAST/).to_stdout
    end

    it 'warns if an invalid command is made' do
      allow(Readline).to receive(:readline).exactly(2).times.and_return('FAKE', 'QUIT')
      expect{@r.accept_commands}.to output(/Invalid option/).to_stderr_from_any_process
    end
  end
end
