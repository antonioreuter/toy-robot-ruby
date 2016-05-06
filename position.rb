class Position
  attr_accessor :col, :row

  def initialize(col: 0, row: 0)
    @col = col
    @row = row
  end

  def to_s
    "#{@col}, #{@row}"
  end

  def self.clone
    new(@col, @row)
  end
end
