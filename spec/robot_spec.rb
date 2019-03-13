require 'robot'

RSpec.describe Robot do

  before :each do
    @r = Robot.new
  end

  describe "#place" do
    it 'remembers the placed position' do
      @r.place('0,4,SOUTH')
      expect(@r.x_coord).to eq(0)
      expect(@r.y_coord).to eq(4)
      expect(@r.facing).to eq('SOUTH')
    end
 
    it 'ignores the PLACE command if there are no args' do
      expect{@r.place('')}.to output(/robot not moved/).to_stderr_from_any_process
      expect(@r.x_coord).to be nil
      expect(@r.y_coord).to be nil
      expect(@r.facing).to be nil
    end

    it 'ignores the PLACE command if the coordinates take the robot off the defined board limits' do
      expect{@r.place('0,9')}.to output(/robot not moved/).to_stderr_from_any_process
      expect(@r.x_coord).to be nil
      expect(@r.y_coord).to be nil
      expect(@r.facing).to be nil
    end
  end

  describe "#report" do
    it 'reports the coordinates and facing position' do
      @r.place('1,2,NORTH')
      expect{@r.report}.to output(/X: 1 Y: 2, Facing: NORTH/).to_stdout
    end
  end
 
  describe "#move" do
    it 'moves the robot one unit forward in the direction it is currently facing' do
      @r.place('0,0,EAST')
      @r.move
      expect{@r.report}.to output(/X: 1 Y: 0, Facing: EAST/).to_stdout
    end

    it 'warns if MOVE would put the robot off the board and does not move the robot' do
      @r.place('0,0,WEST')
      expect{@r.move}.to output(/robot not moved/).to_stderr_from_any_process
      expect(@r.x_coord).to eq 0
      expect(@r.y_coord).to eq 0
    end
  end

  describe "#left" do
    it 'changes the direction the robot is facing LEFT' do
      @r.place('0,0,NORTH')
      @r.left
      expect{@r.report}.to output(/X: 0 Y: 0, Facing: WEST/).to_stdout
    end
  end

  describe "#right" do
    it 'changes the direction the robot is facing RIGHT' do
      @r.place('0,0,NORTH')
      @r.right
      expect{@r.report}.to output(/X: 0 Y: 0, Facing: EAST/).to_stdout
    end
  end
end
