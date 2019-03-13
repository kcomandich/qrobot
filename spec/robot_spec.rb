require 'robot'

RSpec.describe Robot do

  before :each do
    @r = Robot.new
  end

  def send_commands(*commands)
    allow(Readline).to receive(:readline).exactly(commands.count).times.and_return(*commands)
  end

  describe '#accept_commands' do
    it "quits when the user chooses quit" do
      send_commands('QUIT')
    end

    it 'remembers the placed position' do
      send_commands('PLACE 0,4,SOUTH', 'QUIT')
      @r.accept_commands
      expect(@r.x_coord).to eq(0)
      expect(@r.y_coord).to eq(4)
      expect(@r.facing).to eq('SOUTH')
    end

    it 'ignores the PLACE command if there are no args' do
      send_commands('PLACE', 'QUIT')
      expect{@r.accept_commands}.to output(/robot not moved/).to_stderr_from_any_process
      expect(@r.x_coord).to be nil
      expect(@r.y_coord).to be nil
      expect(@r.facing).to be nil
    end

    it 'ignores the PLACE command if the coordinates take the robot off the defined board limits' do
      send_commands('PLACE 0,9', 'QUIT')
      expect{@r.accept_commands}.to output(/robot not moved/).to_stderr_from_any_process
      expect(@r.x_coord).to be nil
      expect(@r.y_coord).to be nil
      expect(@r.facing).to be nil
    end

    it 'ignores all commands until a valid PLACE command is run' do
      send_commands('REPORT', 'QUIT')
      expect{@r.accept_commands}.to output(/Robot is not on the board/).to_stderr_from_any_process
    end

    it 'reports the coordinates and facing position' do
      send_commands('PLACE 1,2,NORTH', 'REPORT', 'QUIT')
      expect{@r.accept_commands}.to output(/X: 1 Y: 2, Facing: NORTH/).to_stdout
    end

    it 'moves the robot one unit forward in the direction it is currently facing' do
      send_commands('PLACE 0,0,EAST', 'MOVE', 'REPORT', 'QUIT')
      expect{@r.accept_commands}.to output(/X: 1 Y: 0, Facing: EAST/).to_stdout
    end

    it 'warns if MOVE would put the robot off the board and does not move the robot' do
      send_commands('PLACE 0,0,WEST', 'MOVE', 'QUIT')
      expect{@r.accept_commands}.to output(/robot not moved/).to_stderr_from_any_process
      expect(@r.x_coord).to eq 0
      expect(@r.y_coord).to eq 0
    end

    it 'changes the direction the robot is facing LEFT' do
      send_commands('PLACE 0,0,NORTH', 'LEFT', 'REPORT', 'QUIT')
      expect{@r.accept_commands}.to output(/X: 0 Y: 0, Facing: WEST/).to_stdout
    end

    it 'changes the direction the robot is facing RIGHT' do
      send_commands('PLACE 0,0,NORTH', 'RIGHT', 'REPORT', 'QUIT')
      expect{@r.accept_commands}.to output(/X: 0 Y: 0, Facing: EAST/).to_stdout
    end

    it 'warns if an invalid command is made' do
      send_commands('FAKE', 'QUIT')
      expect{@r.accept_commands}.to output(/Invalid option/).to_stderr_from_any_process
    end
  end
end
