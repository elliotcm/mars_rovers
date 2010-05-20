class Rover
  def initialize(input)
    starting_position, @move_instructions = input

    starting_position =~ /^(\d+)\s(\d+)\s(\w)$/

    @x_pos = $1.to_i || 0
    @y_pos = $2.to_i || 0
    @orientation = $3 || 'N'

  end

  def process
    @move_instructions.split('').each do |instruction|
      if ['R', 'L'].include?(instruction)
        rotate(instruction)
      elsif instruction == 'M'
        move_forward
      end
    end
  end

  def current_position
    [@x_pos, @y_pos, @orientation].join(' ')
  end

  private
  ROTATION_STATES = {
    'N' => {'R' => 'E', 'L' => 'W'},
    'E' => {'R' => 'S', 'L' => 'N'},
    'S' => {'R' => 'W', 'L' => 'E'},
    'W' => {'R' => 'N', 'L' => 'S'}
  }

  MOVEMENT = {
    'N' => {:axis => :y, :distance => 1},
    'E' => {:axis => :x, :distance => 1},
    'S' => {:axis => :y, :distance => -1},
    'W' => {:axis => :x, :distance => -1}
  }

  def rotate(direction)
    @orientation = ROTATION_STATES[@orientation][direction]
  end

  def move_forward
    case MOVEMENT[@orientation][:axis]
    when :x
      @x_pos += MOVEMENT[@orientation][:distance]
    when :y
      @y_pos += MOVEMENT[@orientation][:distance]
    end
  end
end
