require File.dirname(__FILE__) + '/../lib/rover_controller'

describe RoverController do
  before(:each) do
    @input = [
      "5 5",
      "1 2 N",
      "LMLMLMLMM",
      "3 3 E",
      "MMRMMRMRRM"
    ]
  end
  
  describe ".process(input)" do
    it "outputs the final positions and headings of rovers declared in the input" do
      RoverController.process(@input).
        should == ["1 3 N", "5 1 E"]
    end
  end
  
  describe "#new(input)" do
    it "spawns two rovers" do
      Rover.should_receive(:new).twice
      RoverController.new(@input)
    end
  end
  
  describe "#process" do
    before(:each) do
      @rover_controller = RoverController.new(@input)
      
      @rover_1 = mock(:rover_1, :process => true, :current_position => (@pos1 = mock(:pos1)))
      @rover_2 = mock(:rover_2, :process => true, :current_position => (@pos2 = mock(:pos2)))
      
      @rover_controller.instance_variable_set('@rovers', [@rover_1, @rover_2])
    end
    
    it "processes the move instructions for each rover" do
      @rover_1.should_receive(:process)
      @rover_2.should_receive(:process)
      
      @rover_controller.process
    end
    
    it "outputs an array of the final positions of its rovers" do
      @rover_controller.process.
        should == [@pos1, @pos2]
    end
  end
end
