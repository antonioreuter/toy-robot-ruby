require 'pry'

module Table

  MAX_ROWS = 5
  MAX_COLS = 5

  def self.valid_movement(position)
    if (0..MAX_ROWS).include?(position.row) && (0..MAX_COLS).include?(position.col)
      return true
    else
      fail InvalidMovementException.new("You tried to execute an illegal movement: #{position}")
    end
  end

  class InvalidMovementException < RuntimeError; end
end
