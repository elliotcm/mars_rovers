require 'rover'
require 'enumerator'

class RoverController
  def self.process(input)
    self.new(input).process
  end

  def initialize(input)
    @east_bound, @north_bound = input.shift.split(' ')
    @rovers = []

    input.each_slice(2) do |rover_input|
      @rovers << Rover.new(rover_input)
    end
  end

  def process
    @rovers.each do |rover|
      rover.process
    end

    @rovers.map do |rover|
      rover.current_position
    end
  end
end
