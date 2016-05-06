class Direction
  def initialize(direction, left_direction, right_direction)
    @direction = direction
    @left = left_direction
    @right = right_direction
  end

  NORTH = new(:north, :west, :east)
  WEST =  new(:west, :south, :north)
  SOUTH = new(:south, :east, :west)
  EAST =  new(:east, :north, :south)

  def direction
    @direction
  end

  def left
    Direction.eval_direction @left
  end

  def right
    Direction.eval_direction @right
  end

  def to_s
    "#{@direction.upcase}"
  end

  def self.eval_direction(direction)
    case direction
    when :north
      Direction::NORTH
    when :west
      Direction::WEST
    when :south
      Direction::SOUTH
    when :east
      Direction::EAST
    else
      fail InvalidDirectionException.new("Invalid direction: #{direction}")
    end
  end
end

class InvalidDirectionException < RuntimeError; end
