require File.dirname(__FILE__) + '/../lib/rover'

describe Rover do
  describe "#process" do
    def process_rover(input)
      rover = Rover.new(input)
      rover.process
      rover.current_position
    end
    
    it "handles rotation" do
      process_rover(['0 0 N', 'R']).should == '0 0 E'
      process_rover(['0 0 N', 'RR']).should == '0 0 S'
      process_rover(['0 0 N', 'RL']).should == '0 0 N'
      process_rover(['0 0 N', 'RLLRRLLL']).should == '0 0 S'
    end
    
    it "handles x-plane movement" do
      process_rover(['0 0 E', 'M']).should == '1 0 E'
      process_rover(['3 0 W', 'M']).should == '2 0 W'
      process_rover(['0 0 E', 'MMM']).should == '3 0 E'
    end
    
    it "handles y-plane movement" do
      process_rover(['0 0 N', 'M']).should == '0 1 N'
      process_rover(['0 3 S', 'M']).should == '0 2 S'
      process_rover(['0 0 N', 'MMM']).should == '0 3 N'
    end
    
    it "handles various combinations" do
      process_rover(['1 2 N', 'LMLMLMLMM']).should == '1 3 N'
      process_rover(['3 3 E', 'MMRMMRMRRM']).should == '5 1 E'
    end
  end
  
  describe "#current_position" do
    it "outputs the rover's x-position, y-position and orientation as as string" do
      Rover.new('1 2 E').current_position.should == '1 2 E'
    end
  end
end
