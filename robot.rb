require './direction'
require './position'
require './table'

class Robot
  attr_reader :position, :direction

  def self.execute_commands(file_name)
    @robot = new()
    File.readlines(file_name).each do |cmd|
      begin
        if cmd.start_with?("PLACE")
          attrs = cmd.gsub('PLACE','').split(',').map{ |el| el.strip }
          @robot.place(Position.new(col: attrs[0].to_i,row: attrs[1].to_i), attrs[2].downcase.to_sym)
        elsif cmd.start_with?('MOVE')
          @robot.move
        elsif cmd.start_with?('LEFT')
          @robot.left
        elsif cmd.start_with?('RIGHT')
          @robot.right
        elsif cmd.start_with?('REPORT')
          @robot.report
        end
      rescue Exception => e
        puts "#{e.message}"
      end
    end
  end

  def to_s
    "#{@position}, #{@direction}"
  end

  def place(position, direction)
    @direction = Direction.eval_direction direction
    @position = position if Table::valid_movement(position)
  end

  def move
    if robot_is_on_the_table?
      next_position = forward
      @position = next_position if Table::valid_movement(next_position)
    end
  end

  def left
    @direction = @direction.left if robot_is_on_the_table?
  end

  def right
    @direction = @direction.right if robot_is_on_the_table?
  end

  def report
    puts self.to_s if robot_is_on_the_table?
  end

  def forward
    next_position = @position.clone

    case @direction
    when Direction::NORTH
      next_position.row += 1
    when Direction::SOUTH
      next_position.row -= 1
    when Direction::WEST
      next_position.col -= 1
    when Direction::EAST
      next_position.col += 1
    end

    next_position
  end

  def robot_is_on_the_table?
    if position
      true
    else
      fail RobotNotInTable.new('The robot was not placed in the table')
    end
  end
end

class RobotNotInTable < RuntimeError; end
